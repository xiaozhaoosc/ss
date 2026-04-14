package com.kenzhao.smallsteps.generator.standalone;

import com.kenzhao.smallsteps.generator.domain.GenTable;
import com.kenzhao.smallsteps.generator.domain.GenTableColumn;
import com.kenzhao.smallsteps.generator.util.GenUtils;
import com.kenzhao.smallsteps.generator.util.VelocityInitializer;
import com.kenzhao.smallsteps.generator.util.VelocityUtils;
import org.apache.velocity.Template;
import org.apache.velocity.VelocityContext;
import org.apache.velocity.app.Velocity;

import java.io.File;
import java.io.FileWriter;
import java.io.StringWriter;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Parent 模块独立代码生成器
 * 
 * 使用方法:
 * 1. 确保数据库中已创建 parent_task, parent_reward, parent_contract 表
 * 2. 直接运行 main 方法
 * 3. 生成的代码将输出到 smallsteps-parent 模块
 * 
 * @author 赵轩
 */
public class ParentCodeGenerator {
    
    // 数据库连接配置
    private static final String DB_URL = "jdbc:postgresql://192.168.1.21:15432/smallsteps_db";
    private static final String DB_USER = "smallsteps";
    private static final String DB_PASS = "abdSSsaf#1236548^";
    
    // 生成配置
    private static final String MODULE_NAME = "parent";
    private static final String PACKAGE_NAME = "com.kenzhao.smallsteps.parent";
    private static final String AUTHOR = "赵轩";
    private static final String OUTPUT_DIR = "d:/kenzhao/cust_projects/smallsteps/projects/smallsteps-api/smallsteps-modules/smallsteps-parent/src";
    
    // 要生成代码的表
    private static final String[] TABLES = {
        "ss_parent_task",
        "ss_parent_reward",
        "ss_parent_contract"
    };

    public static void main(String[] args) {
        System.out.println("========================================");
        System.out.println("Parent 模块数据库初始化与代码生成器");
        System.out.println("========================================");
        
        // 初始化 GenConfig 静态配置
        initGenConfig();
        
        try {
            // 初始化 Velocity
            VelocityInitializer.initVelocity();
            System.out.println("✓ Velocity 引擎初始化成功");
            
            // 连接数据库
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS)) {
                System.out.println("✓ 数据库连接成功: " + DB_URL);
                
                // 先创建表结构
                System.out.println("\n--- 创建数据库表 ---");
                createTables(conn);
                System.out.println("✓ 数据库表创建完成");
                
                // 为每个表生成代码
                for (String tableName : TABLES) {
                    System.out.println("\n--- 开始处理表: " + tableName + " ---");
                    generateCode(conn, tableName);
                    System.out.println("✓ " + tableName + " 处理完成");
                }
                
                System.out.println("\n========================================");
                System.out.println("数据库初始化与代码生成完成!");
                System.out.println("输出目录: " + OUTPUT_DIR);
                System.out.println("========================================");
            }
            
        } catch (Exception e) {
            System.err.println("✗ 执行失败:");
            e.printStackTrace();
        }
    }
    
    /**
     * 初始化 GenConfig 静态配置
     */
    private static void initGenConfig() {
        try {
            java.lang.reflect.Field authorField = com.kenzhao.smallsteps.generator.config.GenConfig.class.getDeclaredField("author");
            authorField.setAccessible(true);
            authorField.set(null, AUTHOR);
            
            java.lang.reflect.Field packageNameField = com.kenzhao.smallsteps.generator.config.GenConfig.class.getDeclaredField("packageName");
            packageNameField.setAccessible(true);
            packageNameField.set(null, PACKAGE_NAME);
            
            java.lang.reflect.Field autoRemovePreField = com.kenzhao.smallsteps.generator.config.GenConfig.class.getDeclaredField("autoRemovePre");
            autoRemovePreField.setAccessible(true);
            autoRemovePreField.set(null, true);
            
            java.lang.reflect.Field tablePrefixField = com.kenzhao.smallsteps.generator.config.GenConfig.class.getDeclaredField("tablePrefix");
            tablePrefixField.setAccessible(true);
            tablePrefixField.set(null, "ss_");
            
            System.out.println("✓ GenConfig 配置初始化成功");
        } catch (Exception e) {
            System.err.println("✗ GenConfig 初始化失败:");
            e.printStackTrace();
        }
    }
    
    /**
     * 创建数据库表
     */
    private static void createTables(Connection conn) throws SQLException {
        String[] sqls = {
            "CREATE TABLE IF NOT EXISTS ss_parent_task (task_id bigint NOT NULL, dept_id bigint DEFAULT NULL, parent_id bigint DEFAULT NULL, user_id bigint DEFAULT NULL, title varchar(100) DEFAULT '', description varchar(500) DEFAULT '', icon varchar(100) DEFAULT '', difficulty integer DEFAULT 1, prompt_level integer DEFAULT 1, cycle_type integer DEFAULT 0, reward_points integer DEFAULT 10, light_effect varchar(100) DEFAULT '', audio_effect varchar(100) DEFAULT '', deadline timestamp DEFAULT NULL, status char(1) DEFAULT '0', del_flag char(1) DEFAULT '0', create_dept bigint DEFAULT NULL, create_by bigint DEFAULT NULL, create_time timestamp DEFAULT NULL, update_by bigint DEFAULT NULL, update_time timestamp DEFAULT NULL, PRIMARY KEY (task_id))",
            "COMMENT ON TABLE ss_parent_task IS '家长任务发布表'",
            "CREATE TABLE IF NOT EXISTS ss_parent_reward (reward_id bigint NOT NULL, user_id bigint DEFAULT NULL, name varchar(100) DEFAULT '', points_required integer DEFAULT 100, stock integer DEFAULT -1, icon varchar(100) DEFAULT '', status char(1) DEFAULT '0', create_by bigint DEFAULT NULL, create_time timestamp DEFAULT NULL, update_by bigint DEFAULT NULL, update_time timestamp DEFAULT NULL, del_flag char(1) DEFAULT '0', PRIMARY KEY (reward_id))",
            "COMMENT ON TABLE ss_parent_reward IS '家长奖励配置表'",
            "CREATE TABLE IF NOT EXISTS ss_parent_contract (contract_id bigint NOT NULL, ss_parent_id bigint NOT NULL, child_id bigint NOT NULL, content text, signature_img varchar(500) DEFAULT '', status char(1) DEFAULT '0', create_by bigint DEFAULT NULL, create_time timestamp DEFAULT NULL, update_by bigint DEFAULT NULL, update_time timestamp DEFAULT NULL, del_flag char(1) DEFAULT '0', PRIMARY KEY (contract_id))",
            "COMMENT ON TABLE ss_parent_contract IS '亲子契约表'"
        };
        
        try (Statement stmt = conn.createStatement()) {
            for (String sql : sqls) {
                stmt.execute(sql);
            }
        }
    }
    
    /**
     * 为指定表生成代码
     */
    private static void generateCode(Connection conn, String tableName) throws Exception {
        // 1. 查询表结构
        GenTable genTable = buildGenTable(conn, tableName);
        
        // 2. 查询列信息
        List<GenTableColumn> columns = buildGenTableColumns(conn, tableName);
        genTable.setColumns(columns);
        
        // 3. 初始化表信息
        GenUtils.initTable(genTable);
        
        // 4. 初始化列属性
        for (GenTableColumn column : columns) {
            GenUtils.initColumnField(column, genTable);
        }
        
        // 5. 设置主键
        setPkColumn(genTable);
        
        // 5. 准备 Velocity 上下文
        VelocityContext context = VelocityUtils.prepareContext(genTable);
        
        // 6. 获取模板列表(只生成 Java 后端代码,不生成前端)
        List<String> templates = getBackendTemplates();
        
        // 7. 渲染并写入文件
        for (String template : templates) {
            StringWriter sw = new StringWriter();
            Template tpl = Velocity.getTemplate(template, "UTF-8");
            tpl.merge(context, sw);
            
            String outputPath = getOutputPath(template, genTable);
            writeFile(outputPath, sw.toString());
            System.out.println("  ✓ 生成: " + outputPath);
        }
    }
    
    /**
     * 构建 GenTable 对象
     */
    private static GenTable buildGenTable(Connection conn, String tableName) throws SQLException {
        GenTable genTable = new GenTable();
        genTable.setTableName(tableName);
        genTable.setModuleName(MODULE_NAME);
        genTable.setPackageName(PACKAGE_NAME);
        genTable.setFunctionAuthor(AUTHOR);
        genTable.setTplCategory("crud"); // 使用 CRUD 模板
        
        // 查询表注释
        String sql = "SELECT obj_description(c.oid) AS table_comment " +
                     "FROM pg_class c " +
                     "WHERE c.relname = ? AND c.relkind = 'r'";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, tableName);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    genTable.setTableComment(rs.getString("table_comment"));
                }
            }
        }
        
        return genTable;
    }
    
    /**
     * 构建列信息
     */
    private static List<GenTableColumn> buildGenTableColumns(Connection conn, String tableName) throws SQLException {
        List<GenTableColumn> columns = new ArrayList<>();
        
        String sql = "SELECT " +
                     "  a.attname AS column_name, " +
                     "  t.typname AS data_type, " +
                     "  a.attnotnull AS is_required, " +
                     "  col_description(a.attrelid, a.attnum) AS column_comment, " +
                     "  a.attnum AS sort " +
                     "FROM pg_attribute a " +
                     "JOIN pg_class c ON a.attrelid = c.oid " +
                     "JOIN pg_type t ON a.atttypid = t.oid " +
                     "WHERE c.relname = ? " +
                     "  AND a.attnum > 0 " +
                     "  AND NOT a.attisdropped " +
                     "ORDER BY a.attnum";
        
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, tableName);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    GenTableColumn column = new GenTableColumn();
                    column.setColumnName(rs.getString("column_name"));
                    column.setColumnType(rs.getString("data_type"));
                    column.setColumnComment(rs.getString("column_comment"));
                    column.setSort(rs.getInt("sort"));
                    column.setIsRequired(rs.getBoolean("is_required") ? "1" : "0");
                    columns.add(column);
                }
            }
        }
        
        return columns;
    }
    
    /**
     * 设置主键列
     */
    private static void setPkColumn(GenTable genTable) {
        for (GenTableColumn column : genTable.getColumns()) {
            if (column.isPk()) {
                genTable.setPkColumn(column);
                break;
            }
        }
        
        if (genTable.getPkColumn() == null) {
            genTable.setPkColumn(genTable.getColumns().get(0));
        }
    }
    
    /**
     * 获取后端模板列表
     */
    private static List<String> getBackendTemplates() {
        List<String> templates = new ArrayList<>();
        templates.add("vm/java/domain.java.vm");
        templates.add("vm/java/vo.java.vm");
        templates.add("vm/java/bo.java.vm");
        templates.add("vm/java/mapper.java.vm");
        templates.add("vm/java/service.java.vm");
        templates.add("vm/java/serviceImpl.java.vm");
        templates.add("vm/java/controller.java.vm");
        templates.add("vm/xml/mapper.xml.vm");
        return templates;
    }
    
    /**
     * 获取输出路径
     */
    private static String getOutputPath(String template, GenTable genTable) {
        String className = genTable.getClassName();
        String moduleName = genTable.getModuleName();
        String packagePath = genTable.getPackageName().replace(".", "/");
        
        if (template.contains("domain.java.vm")) {
            return OUTPUT_DIR + "/main/java/" + packagePath + "/domain/" + className + ".java";
        } else if (template.contains("vo.java.vm")) {
            return OUTPUT_DIR + "/main/java/" + packagePath + "/domain/vo/" + className + "Vo.java";
        } else if (template.contains("bo.java.vm")) {
            return OUTPUT_DIR + "/main/java/" + packagePath + "/domain/bo/" + className + "Bo.java";
        } else if (template.contains("mapper.java.vm")) {
            return OUTPUT_DIR + "/main/java/" + packagePath + "/mapper/" + className + "Mapper.java";
        } else if (template.contains("service.java.vm")) {
            return OUTPUT_DIR + "/main/java/" + packagePath + "/service/I" + className + "Service.java";
        } else if (template.contains("serviceImpl.java.vm")) {
            return OUTPUT_DIR + "/main/java/" + packagePath + "/service/impl/" + className + "ServiceImpl.java";
        } else if (template.contains("controller.java.vm")) {
            return OUTPUT_DIR + "/main/java/" + packagePath + "/controller/" + className + "Controller.java";
        } else if (template.contains("mapper.xml.vm")) {
            return OUTPUT_DIR + "/main/resources/mapper/" + moduleName + "/" + className + "Mapper.xml";
        }
        
        return OUTPUT_DIR + "/unknown";
    }
    
    /**
     * 写入文件
     */
    private static void writeFile(String filePath, String content) throws Exception {
        File file = new File(filePath);
        File parentDir = file.getParentFile();
        
        // 创建父目录
        if (!parentDir.exists()) {
            parentDir.mkdirs();
        }
        
        // 写入文件
        try (FileWriter writer = new FileWriter(file)) {
            writer.write(content);
        }
    }
}
