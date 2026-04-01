package com.xiaozhi.dialogue.vad.impl;

import ai.onnxruntime.OnnxTensor;
import ai.onnxruntime.OrtEnvironment;
import ai.onnxruntime.OrtException;
import ai.onnxruntime.OrtSession;
import ai.onnxruntime.OrtLoggingLevel;
import com.xiaozhi.common.config.OnnxRuntimeConfig;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import com.xiaozhi.dialogue.vad.VadModel;
import com.xiaozhi.utils.AudioUtils;

import jakarta.annotation.PostConstruct;
import jakarta.annotation.PreDestroy;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

@Component
public class SileroVadModelOptimized implements VadModel {
    private static final Logger logger = LoggerFactory.getLogger(SileroVadModelOptimized.class);

    @Value("${vad.model.path:models/silero_vad.onnx}")
    private String modelPath;

    @Autowired
    private Optional<OnnxRuntimeConfig.OnnxRuntimeProperties> onnxProperties;

    private OrtEnvironment env;
    private OrtSession session;
    private float[][][] state;
    private float[][] context;
    private final int windowSize = AudioUtils.BUFFER_SIZE;

    @PostConstruct
    @Override
    public void initialize() {
        try {
            env = OrtEnvironment.getEnvironment();
            OrtSession.SessionOptions opts = new OrtSession.SessionOptions();
            opts.setSessionLogLevel(OrtLoggingLevel.ORT_LOGGING_LEVEL_ERROR);
            
            int interOpThreads = onnxProperties.map(OnnxRuntimeConfig.OnnxRuntimeProperties::interOpThreads).orElse(16);
            int intraOpThreads = onnxProperties.map(OnnxRuntimeConfig.OnnxRuntimeProperties::intraOpThreads).orElse(16);
            
            opts.setInterOpNumThreads(interOpThreads);
            opts.setIntraOpNumThreads(intraOpThreads);
            
            opts.addCPU(true);
            
            boolean enableGpu = onnxProperties.map(OnnxRuntimeConfig.OnnxRuntimeProperties::enableGpu).orElse(false);
            if (enableGpu) {
                try {
                    int cudaDeviceId = onnxProperties.map(OnnxRuntimeConfig.OnnxRuntimeProperties::cudaDeviceId).orElse(0);
                    opts.addCUDA(cudaDeviceId);
                    logger.info("CUDA GPU acceleration enabled for VAD model");
                } catch (OrtException e) {
                    logger.warn("Failed to enable CUDA, falling back to CPU: {}", e.getMessage());
                }
            }
            
            opts.setGraphOptimizationLevel(OrtSession.SessionOptions.GraphOptimizationLevel.ORT_ENABLE_ALL);
            
            session = env.createSession(modelPath, opts);
            reset();
            
            logger.info("Silero VAD模型初始化成功 - InterOpThreads: {}, IntraOpThreads: {}, GPU: {}", 
                interOpThreads, intraOpThreads, enableGpu);
        } catch (UnsatisfiedLinkError e) {
            logger.error("ONNX Runtime native libraries加载失败: {}", e.getMessage());
            throw new RuntimeException("ONNX Runtime native libraries加载失败", e);
        } catch (OrtException e) {
            logger.error("Silero VAD模型初始化失败", e);
            throw new RuntimeException("VAD模型初始化失败", e);
        }
    }

    @Override
    public float getSpeechProbability(float[] samples) {
        try {
            if (samples.length != windowSize) {
                throw new IllegalArgumentException("样本数量必须是" + windowSize);
            }

            float[][] x = new float[][] { samples };

            OnnxTensor inputTensor = OnnxTensor.createTensor(env, x);
            OnnxTensor stateTensor = OnnxTensor.createTensor(env, state);
            OnnxTensor srTensor = OnnxTensor.createTensor(env, new long[] { AudioUtils.SAMPLE_RATE });

            Map<String, OnnxTensor> inputs = new HashMap<>();
            inputs.put("input", inputTensor);
            inputs.put("sr", srTensor);
            inputs.put("state", stateTensor);

            try {
                OrtSession.Result result = session.run(inputs);

                float[][] output = (float[][]) result.get(0).getValue();
                state = (float[][][]) result.get(1).getValue();

                context = x;

                return output[0][0];
            } finally {
                inputTensor.close();
                stateTensor.close();
                srTensor.close();
            }
        } catch (OrtException e) {
            logger.error("VAD模型推理失败", e);
            return 0.0f;
        }
    }

    @Override
    public InferenceResult infer(float[] samples, float[][][] prevState) {
        try {
            if (samples.length != windowSize) {
                throw new IllegalArgumentException("样本数量必须是" + windowSize);
            }

            float[][] x = new float[][] { samples };

            float[][][] localState = prevState;
            if (localState == null) {
                localState = new float[2][1][128];
            }

            OnnxTensor inputTensor = OnnxTensor.createTensor(env, x);
            OnnxTensor stateTensor = OnnxTensor.createTensor(env, localState);
            OnnxTensor srTensor = OnnxTensor.createTensor(env, new long[] { AudioUtils.SAMPLE_RATE });

            try {
                OrtSession.Result result = session.run(Map.of(
                        "input", inputTensor,
                        "sr", srTensor,
                        "state", stateTensor
                ));

                float[][] output = (float[][]) result.get(0).getValue();
                float[][][] nextState = (float[][][]) result.get(1).getValue();

                return new InferenceResult(output[0][0], nextState);
            } finally {
                inputTensor.close();
                stateTensor.close();
                srTensor.close();
            }
        } catch (OrtException e) {
            logger.error("VAD模型推理失败", e);
            return new InferenceResult(0.0f, prevState);
        }
    }

    @Override
    public void reset() {
        state = new float[2][1][128];
        context = new float[0][];
    }

    @PreDestroy
    @Override
    public void close() {
        try {
            if (session != null) {
                session.close();
            }
            logger.info("Silero VAD模型资源已释放");
        } catch (OrtException e) {
            logger.error("关闭VAD模型失败", e);
        }
    }
}
