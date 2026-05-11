package com.kenzhao.smallsteps.web.controller.common;

import com.kenzhao.smallsteps.common.core.domain.R;
import com.kenzhao.smallsteps.common.web.core.BaseController;
import com.kenzhao.smallsteps.system.domain.vo.SysOssUploadVo;
import com.kenzhao.smallsteps.system.domain.vo.SysOssVo;
import com.kenzhao.smallsteps.system.service.ISysOssService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import cn.dev33.satoken.annotation.SaCheckLogin;

/**
 * 通用请求处理
 *
 * @author 赵轩
 */
@SaCheckLogin
@RequiredArgsConstructor
@RestController
@RequestMapping("/common")
public class CommonController extends BaseController {

    private final ISysOssService ossService;

    /**
     * 通用上传请求（供移动端等基础权限用户使用）
     */
    @PostMapping(value = "/upload", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public R<SysOssUploadVo> upload(@RequestPart("file") MultipartFile file) {
        SysOssVo oss = ossService.upload(file);
        SysOssUploadVo uploadVo = new SysOssUploadVo();
        uploadVo.setUrl(oss.getUrl());
        uploadVo.setFileName(oss.getOriginalName());
        uploadVo.setOssId(oss.getOssId().toString());
        return R.ok(uploadVo);
    }
}
