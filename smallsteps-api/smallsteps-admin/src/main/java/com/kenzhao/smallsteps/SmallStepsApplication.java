package com.kenzhao.smallsteps;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.metrics.buffering.BufferingApplicationStartup;
import org.springframework.context.annotation.ComponentScan;

/**
 * 启动程序
 *
 * @author 赵轩
 */

//@ComponentScan(basePackages = {"com.kenzhao.smallsteps"})
@SpringBootApplication
public class SmallStepsApplication {

    public static void main(String[] args) {
        SpringApplication application = new SpringApplication(SmallStepsApplication.class);
        application.setApplicationStartup(new BufferingApplicationStartup(2048));
        application.run(args);
        System.out.println("ADHD中小学生（儿童）行为习惯辅助系统启动成功ﾞ");
    }

}
