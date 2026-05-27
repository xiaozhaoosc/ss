package com.kenzhao.smallsteps.system.service.impl;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.convert.Convert;
import cn.hutool.core.util.ObjectUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import com.kenzhao.smallsteps.common.core.constant.CacheNames;
import com.kenzhao.smallsteps.common.core.domain.dto.OssDTO;
import com.kenzhao.smallsteps.common.core.exception.ServiceException;
import com.kenzhao.smallsteps.common.core.service.OssService;
import com.kenzhao.smallsteps.common.core.utils.MapstructUtils;
import com.kenzhao.smallsteps.common.core.utils.SpringUtils;
import com.kenzhao.smallsteps.common.core.utils.StreamUtils;
import com.kenzhao.smallsteps.common.core.utils.StringUtils;
import com.kenzhao.smallsteps.common.core.utils.file.FileUtils;
import com.kenzhao.smallsteps.common.json.utils.JsonUtils;
import com.kenzhao.smallsteps.common.mybatis.core.page.PageQuery;
import com.kenzhao.smallsteps.common.mybatis.core.page.TableDataInfo;
import com.kenzhao.smallsteps.common.oss.core.OssClient;
import com.kenzhao.smallsteps.common.oss.entity.UploadResult;
import com.kenzhao.smallsteps.common.oss.enums.AccessPolicyType;
import com.kenzhao.smallsteps.common.oss.factory.OssFactory;
import com.kenzhao.smallsteps.system.domain.SysOss;
import com.kenzhao.smallsteps.system.domain.SysOssExt;
import com.kenzhao.smallsteps.system.domain.bo.SysOssBo;
import com.kenzhao.smallsteps.system.domain.vo.SysOssVo;
import com.kenzhao.smallsteps.system.mapper.SysOssMapper;
import com.kenzhao.smallsteps.system.service.ISysOssService;
import org.jetbrains.annotations.NotNull;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.time.Duration;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Map;

/**
 * 文件上传 服务层实现
 *
 * @author 赵轩
 */
@RequiredArgsConstructor
@Service
public class SysOssServiceImpl implements ISysOssService, OssService {

    @org.springframework.beans.factory.annotation.Value("${ruoyi.profile:D:/smallsteps/uploadPath}")
    private String profilePath;

    private final SysOssMapper baseMapper;

    /**
     * 查询OSS对象存储列表
     *
     * @param bo        OSS对象存储分页查询对象
     * @param pageQuery 分页查询实体类
     * @return 结果
     */
    @Override
    public TableDataInfo<SysOssVo> queryPageList(SysOssBo bo, PageQuery pageQuery) {
        LambdaQueryWrapper<SysOss> lqw = buildQueryWrapper(bo);
        Page<SysOssVo> result = baseMapper.selectVoPage(pageQuery.build(), lqw);
        List<SysOssVo> filterResult = StreamUtils.toList(result.getRecords(), this::matchingUrl);
        result.setRecords(filterResult);
        return TableDataInfo.build(result);
    }

    /**
     * 根据一组 ossIds 获取对应的 SysOssVo 列表
     *
     * @param ossIds 一组文件在数据库中的唯一标识集合
     * @return 包含 SysOssVo 对象的列表
     */
    @Override
    public List<SysOssVo> listByIds(Collection<Long> ossIds) {
        List<SysOssVo> list = new ArrayList<>();
        SysOssServiceImpl ossService = SpringUtils.getAopProxy(this);
        for (Long id : ossIds) {
            SysOssVo vo = ossService.getById(id);
            if (ObjectUtil.isNotNull(vo)) {
                try {
                    list.add(this.matchingUrl(vo));
                } catch (Exception ignored) {
                    // 如果oss异常无法连接则将数据直接返回
                    list.add(vo);
                }
            }
        }
        return list;
    }

    /**
     * 根据一组 ossIds 获取对应文件的 URL 列表
     *
     * @param ossIds 以逗号分隔的 ossId 字符串
     * @return 以逗号分隔的文件 URL 字符串
     */
    @Override
    public String selectUrlByIds(String ossIds) {
        List<String> list = new ArrayList<>();
        SysOssServiceImpl ossService = SpringUtils.getAopProxy(this);
        for (Long id : StringUtils.splitTo(ossIds, Convert::toLong)) {
            SysOssVo vo = ossService.getById(id);
            if (ObjectUtil.isNotNull(vo)) {
                try {
                    list.add(this.matchingUrl(vo).getUrl());
                } catch (Exception ignored) {
                    // 如果oss异常无法连接则将数据直接返回
                    list.add(vo.getUrl());
                }
            }
        }
        return StringUtils.joinComma(list);
    }

    @Override
    public List<OssDTO> selectByIds(String ossIds) {
        List<OssDTO> list = new ArrayList<>();
        for (Long id : StringUtils.splitTo(ossIds, Convert::toLong)) {
            SysOssVo vo = SpringUtils.getAopProxy(this).getById(id);
            if (ObjectUtil.isNotNull(vo)) {
                try {
                    vo.setUrl(this.matchingUrl(vo).getUrl());
                    list.add(BeanUtil.toBean(vo, OssDTO.class));
                } catch (Exception ignored) {
                    // 如果oss异常无法连接则将数据直接返回
                    list.add(BeanUtil.toBean(vo, OssDTO.class));
                }
            }
        }
        return list;
    }

    private LambdaQueryWrapper<SysOss> buildQueryWrapper(SysOssBo bo) {
        Map<String, Object> params = bo.getParams();
        LambdaQueryWrapper<SysOss> lqw = Wrappers.lambdaQuery();
        lqw.like(StringUtils.isNotBlank(bo.getFileName()), SysOss::getFileName, bo.getFileName());
        lqw.like(StringUtils.isNotBlank(bo.getOriginalName()), SysOss::getOriginalName, bo.getOriginalName());
        lqw.eq(StringUtils.isNotBlank(bo.getFileSuffix()), SysOss::getFileSuffix, bo.getFileSuffix());
        lqw.eq(StringUtils.isNotBlank(bo.getUrl()), SysOss::getUrl, bo.getUrl());
        lqw.between(params.get("beginCreateTime") != null && params.get("endCreateTime") != null,
            SysOss::getCreateTime, params.get("beginCreateTime"), params.get("endCreateTime"));
        lqw.eq(ObjectUtil.isNotNull(bo.getCreateBy()), SysOss::getCreateBy, bo.getCreateBy());
        lqw.eq(StringUtils.isNotBlank(bo.getService()), SysOss::getService, bo.getService());
        lqw.orderByAsc(SysOss::getOssId);
        return lqw;
    }

    /**
     * 根据 ossId 从缓存或数据库中获取 SysOssVo 对象
     *
     * @param ossId 文件在数据库中的唯一标识
     * @return SysOssVo 对象，包含文件信息
     */
    @Cacheable(cacheNames = CacheNames.SYS_OSS, key = "#ossId")
    @Override
    public SysOssVo getById(Long ossId) {
        return baseMapper.selectVoById(ossId);
    }


    /**
     * 文件下载方法，支持一次性下载完整文件
     *
     * @param ossId    OSS对象ID
     * @param response HttpServletResponse对象，用于设置响应头和向客户端发送文件内容
     */
    @Override
    public void download(Long ossId, HttpServletResponse response) throws IOException {
        SysOssVo sysOss = SpringUtils.getAopProxy(this).getById(ossId);
        if (ObjectUtil.isNull(sysOss)) {
            throw new ServiceException("文件数据不存在!");
        }
        FileUtils.setAttachmentResponseHeader(response, sysOss.getOriginalName());
        response.setContentType(MediaType.APPLICATION_OCTET_STREAM_VALUE + "; charset=UTF-8");
        
        File file = new File(profilePath + "/" + sysOss.getFileName());
        if (!file.exists()) {
            throw new ServiceException("文件物理不存在!");
        }
        response.setContentLengthLong(file.length());
        try (java.io.FileInputStream fis = new java.io.FileInputStream(file)) {
            cn.hutool.core.io.IoUtil.copy(fis, response.getOutputStream());
        }
    }

    /**
     * 上传 MultipartFile 到对象存储服务，并保存文件信息到数据库
     *
     * @param file 要上传的 MultipartFile 对象
     * @return 上传成功后的 SysOssVo 对象，包含文件信息
     * @throws ServiceException 如果上传过程中发生异常，则抛出 ServiceException 异常
     */
    @Override
    public SysOssVo upload(MultipartFile file) {
        if (ObjectUtil.isNull(file) || file.isEmpty()) {
            throw new ServiceException("上传文件不能为空");
        }
        String originalfileName = file.getOriginalFilename();
        String suffix = StringUtils.substring(originalfileName, originalfileName.lastIndexOf("."), originalfileName.length());
        
        String fileName = cn.hutool.core.util.IdUtil.fastSimpleUUID() + suffix;
        String datePath = com.kenzhao.smallsteps.common.core.utils.DateUtils.datePath();
        String relativePath = "/" + datePath + "/" + fileName;
        File desc = new File(profilePath + relativePath);
        if (!desc.getParentFile().exists()) {
            desc.getParentFile().mkdirs();
        }
        try {
            file.transferTo(desc);
        } catch (Exception e) {
            throw new ServiceException("上传文件失败", e);
        }

        SysOssExt ext1 = new SysOssExt();
        ext1.setFileSize(file.getSize());
        ext1.setContentType(file.getContentType());
        
        UploadResult uploadResult = UploadResult.builder()
                .url("/profile/upload" + relativePath)
                .filename(datePath + "/" + fileName)
                .build();
                
        return buildResultEntity(originalfileName, suffix, "local", uploadResult, ext1);
    }

    /**
     * 上传文件到对象存储服务，并保存文件信息到数据库
     *
     * @param file 要上传的文件对象
     * @return 上传成功后的 SysOssVo 对象，包含文件信息
     */
    @Override
    public SysOssVo upload(File file) {
        if (ObjectUtil.isNull(file) || !file.isFile() || file.length() <= 0) {
            throw new ServiceException("上传文件不能为空");
        }
        String originalfileName = file.getName();
        String suffix = StringUtils.substring(originalfileName, originalfileName.lastIndexOf("."), originalfileName.length());
        
        String fileName = cn.hutool.core.util.IdUtil.fastSimpleUUID() + suffix;
        String datePath = com.kenzhao.smallsteps.common.core.utils.DateUtils.datePath();
        String relativePath = "/" + datePath + "/" + fileName;
        File desc = new File(profilePath + relativePath);
        if (!desc.getParentFile().exists()) {
            desc.getParentFile().mkdirs();
        }
        try {
            cn.hutool.core.io.FileUtil.copy(file, desc, true);
        } catch (Exception e) {
            throw new ServiceException("上传文件失败", e);
        }
        
        long length = file.length();
        SysOssExt ext1 = new SysOssExt();
        ext1.setFileSize(length);
        
        UploadResult uploadResult = UploadResult.builder()
                .url("/profile/upload" + relativePath)
                .filename(datePath + "/" + fileName)
                .build();
                
        return buildResultEntity(originalfileName, suffix, "local", uploadResult, ext1);
    }

    @NotNull
    private SysOssVo buildResultEntity(String originalfileName, String suffix, String configKey, UploadResult uploadResult, SysOssExt ext1) {
        SysOss oss = new SysOss();
        oss.setUrl(uploadResult.getUrl());
        oss.setFileSuffix(suffix);
        oss.setFileName(uploadResult.getFilename());
        oss.setOriginalName(originalfileName);
        oss.setService(configKey);
        oss.setExt1(JsonUtils.toJsonString(ext1));
        baseMapper.insert(oss);
        SysOssVo sysOssVo = MapstructUtils.convert(oss, SysOssVo.class);
        return this.matchingUrl(sysOssVo);
    }

    /**
     * 删除OSS对象存储
     *
     * @param ids     OSS对象ID串
     * @param isValid 判断是否需要校验
     * @return 结果
     */
    @Override
    public Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid) {
        if (isValid) {
            // 做一些业务上的校验,判断是否需要校验
        }
        List<SysOss> list = baseMapper.selectByIds(ids);
        for (SysOss sysOss : list) {
            File file = new File(profilePath + "/" + sysOss.getFileName());
            if (file.exists()) {
                file.delete();
            }
        }
        return baseMapper.deleteByIds(ids) > 0;
    }

    /**
     * 桶类型为 private 的URL 修改为临时URL时长为120s
     *
     * @param oss OSS对象
     * @return oss 匹配Url的OSS对象
     */
    private SysOssVo matchingUrl(SysOssVo oss) {
        // 本地环境直接返回路径
        return oss;
    }
}
