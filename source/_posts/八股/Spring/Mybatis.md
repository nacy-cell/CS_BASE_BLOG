---
title: "Mybatis"  
date: 2025-11-27 20:48:52
categories: 
  - 八股
  - Spring
---

## 与传统的JDBC相比，MyBatis的优点？

* **基于 SQL 语句编程**，相当灵活，不会对应用程序或者数据库的现有设计造成任 何影响，SQL 写在XML 里，解除 sql 与程序代码的耦合，便于统一管理；提供 XML 标签，支持编写动态 SQL 语句，并可重用。
* 与 JDBC 相比，**减少了 50%以上的代码量**，消除了 JDBC 大量冗余的代码，不 需要手动开关连接；
* **很好的与各种数据库兼容**，因为 MyBatis 使用 JDBC 来连接数据库，所以只要 JDBC 支持的数据库MyBatis 都支持。
* 能够**与 Spring 很好的集成**，开发效率高
* **提供映射标签**，支持对象与数据库的 ORM 字段关系映射；提供对象关系映射 标签，支持对象关系组件维护。

## MyBatis觉得在哪方面做的比较好？

MyBatis 在 SQL 灵活性、动态 SQL 支持、结果集映射和与 Spring 整合方面表现卓越，尤其适合重视SQL 可控性的项目。

* **SQL 与代码解耦，灵活可控**：MyBatis 允许开发者直接编写和优化 SQL，相比全自动 ORM，MyBatis 让开发者明确知道每条 SQL 的执行逻辑，便于性能调优。
* **动态 SQL 的强大支持**：比如可以动态拼接SQL，通过 \<if\> , \<choose\> , \<foreach\> 等标签动态生成 SQL，避免 Java 代码中繁琐的字符串拼接。
* **自动映射与自定义映射结合**：自动将查询结果字段名与对象属性名匹配（如驼峰转换）。
* **插件扩展机制**：可编写插件拦截 SQL 执行过程，实现分页、性能监控、SQL 改写等通用逻辑。
* **与 Spring 生态无缝集成**：通过 @MapperScan 快速扫描 Mapper 接口，结合 Spring 事务管理，配置简洁高效。

## 还记得JDBC连接数据库的步骤吗？

使用Java JDBC连接数据库的一般步骤如下：

1. **加载数据库驱动程序**：在使用JDBC连接数据库之前，需要加载相应的数据库驱动程序。可以通过Class.forName("com.mysql.jdbc.Driver") 来加载MySQL数据库的驱动程序。不同数据库的驱动类名会有所不同。
2. **建立数据库连接**：使用 DriverManager 类的 getConnection(url, username, password) 方法来连接数据库，其中url是数据库的连接字符串（包括数据库类型、主机、端口等）、username是数据库用户名，password是密码。
3. **创建 Statement 对象**：通过 Connection 对象的 createStatement() 方法创建一个 Statement 对象，用于执行 SQL 查询或更新操作。
4. **执行 SQL 查询或更新操作**：使用 Statement 对象的 executeQuery(sql) 方法来执行 SELECT 查询操作，或者使用 executeUpdate(sql) 方法来执行 INSERT、UPDATE 或 DELETE 操作。
5. **处理查询结果**：如果是 SELECT 查询操作，通过 ResultSet 对象来处理查询结果。可以使用
ResultSet 的 next() 方法遍历查询结果集，然后通过 getXXX() 方法获取各个字段的值。
6. **关闭连接**：在完成数据库操作后，需要逐级关闭数据库连接相关对象，即先关闭 ResultSet，再关闭 Statement，最后关闭 Connection。

## 如果项目中要用到原生的mybatis去查询，该怎样写？

步骤概述：

1. **配置MyBatis**： 在项目中配置MyBatis的数据源、SQL映射文件等。
2. **创建实体类**： 创建用于映射数据库表的实体类。
3. **编写SQL映射文件**： 创建XML文件，定义SQL语句和映射关系。
4. **编写DAO接口**： 创建DAO接口，定义数据库操作的方法。
5. **编写具体的SQL查询语句**： 在DAO接口中定义查询方法，并在XML文件中编写对应的SQL语句。
6. **调用查询方法**： 在服务层或控制层调用DAO接口中的方法进行查询。

## Mybatis里的 # 和 $ 的区别？

* Mybatis 在处理 #{} 时，会创建预编译的 SQL 语句，将 SQL 中的 #{} 替换为 ? 号，在执行 SQL 时会为预编译 SQL 中的占位符（?）赋值，调用PreparedStatement 的 set 方法来赋值，预编译的SQL 语句执行效率高，并且可以防止SQL 注入，提供更高的安全性，适合传递参数值。
* Mybatis 在处理 ${} 时，只是创建普通的 SQL 语句，然后在执行 SQL 语句时 MyBatis 将参数直接拼入到 SQL 里，不能防止 SQL 注入，因为参数直接拼接到 SQL 语句中，如果参数未经过验证、过滤，可能会导致安全问题

## MybatisPlus和Mybatis的区别？

MybatisPlus是一个基于MyBatis的增强工具库，旨在简化开发并提高效率。以下是MybatisPlus和
MyBatis之间的一些主要区别：

* **CRUD操作**：MybatisPlus通过继承BaseMapper接口，提供了一系列内置的快捷方法，使得CRUD操作更加简单，无需编写重复的SQL语句。
* **代码生成器**：MybatisPlus提供了代码生成器功能，可以根据数据库表结构自动生成实体类、Mapper接口以及XML映射文件，减少了手动编写的工作量。
* **通用方法封装**：MybatisPlus封装了许多常用的方法，如条件构造器、排序、分页查询等，简化了开发过程，提高了开发效率。
* **分页插件**：MybatisPlus内置了分页插件，支持各种数据库的分页查询，开发者可以轻松实现分页功能，而在传统的MyBatis中，需要开发者自己手动实现分页逻辑。
* **多租户支持**：MybatisPlus提供了多租户的支持，可以轻松实现多租户数据隔离的功能。
* **注解支持**：MybatisPlus引入了更多的注解支持，使得开发者可以通过注解来配置实体与数据库表之间的映射关系，减少了XML配置文件的编写

## MyBatis运用了哪些常见的设计模式？

* **建造者模式**（Builder），如：SqlSessionFactoryBuilder、XMLConfigBuilder、XMLMapperBuilder、XMLStatementBuilder、CacheBuilder等；
* **工厂模式**，如：SqlSessionFactory、ObjectFactory、MapperProxyFactory；
* **单例模式**，例如ErrorContext和LogFactory；
* **代理模式**，Mybatis实现的核心，比如MapperProxy、ConnectionLogger，用的jdk的动态代理；还有executor.loader包使用了cglib或者javassist达到延迟加载的效果；
* **组合模式**，例如SqlNode和各个子类ChooseSqlNode等；
* **模板方法模式**，例如BaseExecutor和SimpleExecutor，还有BaseTypeHandler和所有的子类例如IntegerTypeHandler；
* **适配器模式**，例如Log的Mybatis接口和它对jdbc、log4j等各种日志框架的适配实现；
* **装饰者模式**，例如Cache包中的cache.decorators子包中等各个装饰者的实现；
* **迭代器模式**，例如迭代器模式PropertyTokenizer；

