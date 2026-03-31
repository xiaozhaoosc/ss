package com.kenzhao.smallsteps.monitor.admin;

import de.codecentric.boot.admin.server.config.EnableAdminServer;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/**
 * Admin 监控启动程序
 *
 * @author 赵轩
 */
@EnableAdminServer
@SpringBootApplication
public class MonitorAdminApplication {

    public static void main(String[] args) {
        SpringApplication.run(MonitorAdminApplication.class, args);
        System.out.println("Admin 监控启动成功");
    }

}
