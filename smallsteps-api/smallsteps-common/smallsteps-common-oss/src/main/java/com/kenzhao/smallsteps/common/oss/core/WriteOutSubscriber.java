package com.kenzhao.smallsteps.common.oss.core;

import java.io.IOException;

/**
 * 写出订阅器
 *
 * @author 赵轩
 */
@FunctionalInterface
public interface WriteOutSubscriber<T> {

    void writeTo(T out) throws IOException;

}
