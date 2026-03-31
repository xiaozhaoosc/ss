package com.kenzhao.smallsteps.generator.test;

import com.kenzhao.smallsteps.generator.domain.GenTable;
import com.kenzhao.smallsteps.generator.service.IGenTableService;
import com.kenzhao.smallsteps.generator.util.GenUtils;
import com.kenzhao.smallsteps.common.mybatis.core.page.PageQuery;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

import org.junit.jupiter.api.Tag;

import org.springframework.test.context.ActiveProfiles;

/**
 * 家长端代码自动化生成工具
 * Usage: 运行 testGenerateParentCode() 即可自动生成 parent_task, parent_reward 等表的代码到 smallsteps-parent 模块
 */
@Tag("dev")
@ActiveProfiles("test")
@SpringBootTest(classes = TestApplication.class)
public class ParentCodeGenTest {

    @Autowired
    private IGenTableService genTableService;

    // 默认数据源配置 (Dev环境)
    private static final String DB_URL = "jdbc:postgresql://192.168.1.21:15432/smallsteps_db?useUnicode=true&characterEncoding=utf8&useSSL=true";
    private static final String DB_USER = "smallsteps";
    private static final String DB_PASS = "abdSSsaf#1236548^";

    // 目标生成路径 (绝对路径)
    private static final String TARGET_MODULE_PATH = "d:/kenzhao/cust_projects/smallsteps/projects/smallsteps-api/smallsteps-modules/smallsteps-parent";

    @Test
    public void testGenerateParentCode() throws Exception {
        System.out.println(">>> 1. 初始化数据库表结构...");
        initDbSchema();

        System.out.println(">>> 2. 导入表元数据...");
        String[] tables = {"parent_task", "parent_reward", "parent_contract"};
        List<GenTable> tableList = genTableService.selectDbTableListByNames(tables, "master");
        genTableService.importGenTable(tableList, "master");

        System.out.println(">>> 3. 配置生成参数...");
        for (String tableName : tables) {
            configureTable(tableName);
        }

        System.out.println(">>> 4. 执行代码生成...");
        generateCode(tables);

        System.out.println(">>> 生成完成! 请检查: " + TARGET_MODULE_PATH);
    }

    private void initDbSchema() {
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
             Statement stmt = conn.createStatement()) {
            
            String sqlPath = "d:/kenzhao/cust_projects/smallsteps/projects/smallsteps-api/smallsteps-modules/smallsteps-generator/src/test/resources/parent_schema.sql";
            String sqlContent = Files.lines(Paths.get(sqlPath)).collect(Collectors.joining("\n"));
            
            // 分割语句并逐条执行
            String[] sqls = sqlContent.split(";");
            for (String sql : sqls) {
                if (sql.trim().isEmpty()) continue;
                System.out.println("Executing SQL: " + sql.trim().substring(0, Math.min(50, sql.trim().length())) + "...");
                stmt.execute(sql);
            }
            System.out.println("DB Schema initialized.");
        } catch (Exception e) {
            throw new RuntimeException("DB Init Failed", e);
        }
    }

    private void configureTable(String tableName) {
        // 1. 查找已导入的表信息
        GenTable query = new GenTable();
        query.setTableName(tableName);
        List<GenTable> list = genTableService.selectPageGenTableList(query, new PageQuery(100, 1)).getRows();
        if (list.isEmpty()) return;
        
        GenTable table = genTableService.selectGenTableById(list.get(0).getTableId());

        // 2. 更新生成配置
        table.setPackageName("com.kenzhao.smallsteps.parent");
        table.setModuleName("parent");
        
        // table_name: parent_task -> business_name: task
        String businessName = tableName.replace("parent_", "");
        table.setBusinessName(businessName);
        table.setFunctionName("家长" + businessName);
        table.setFunctionAuthor("kenzhao");

        // 设置为自定义路径生成
        table.setGenType("1"); 
        table.setGenPath(TARGET_MODULE_PATH);

        genTableService.updateGenTable(table);
        System.out.println("Configured table: " + tableName);
    }

    private void generateCode(String[] tableNames) {
        for (String tableName : tableNames) {
            // 再次查询获取 ID
            GenTable query = new GenTable();
            query.setTableName(tableName);
            List<GenTable> list = genTableService.selectPageGenTableList(query, new PageQuery(100, 1)).getRows();
            if (!list.isEmpty()) {
                Long tableId = list.get(0).getTableId();
                genTableService.generatorCode(tableId);
                System.out.println("Generated code for: " + tableName);
            }
        }
    }
}
