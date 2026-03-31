package com.xiaozhi.common.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class OnnxRuntimeConfig {

    @Value("${onnx.runtime.inter-op-threads:16}")
    private int interOpThreads;

    @Value("${onnx.runtime.intra-op-threads:16}")
    private int intraOpThreads;

    @Value("${onnx.runtime.execution-mode:SEQUENTIAL}")
    private String executionMode;

    @Value("${onnx.runtime.graph-optimization-level:ALL}")
    private String graphOptimizationLevel;

    @Value("${onnx.runtime.enable-cpu:true}")
    private boolean enableCpu;

    @Value("${onnx.runtime.enable-gpu:false}")
    private boolean enableGpu;

    @Value("${onnx.runtime.cuda-device-id:0}")
    private int cudaDeviceId;

    @Value("${onnx.runtime.memory-pattern:true}")
    private boolean memoryPattern;

    @Value("${onnx.runtime.gpu-mem-limit:12884901888}")
    private long gpuMemLimit;

    @Bean
    public OnnxRuntimeProperties onnxRuntimeProperties() {
        return new OnnxRuntimeProperties(
            interOpThreads,
            intraOpThreads,
            executionMode,
            graphOptimizationLevel,
            enableCpu,
            enableGpu,
            cudaDeviceId,
            memoryPattern,
            gpuMemLimit
        );
    }

    public record OnnxRuntimeProperties(
        int interOpThreads,
        int intraOpThreads,
        String executionMode,
        String graphOptimizationLevel,
        boolean enableCpu,
        boolean enableGpu,
        int cudaDeviceId,
        boolean memoryPattern,
        long gpuMemLimit
    ) {}
}
