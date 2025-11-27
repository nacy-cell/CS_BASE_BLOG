---
title: "SpringBoot"  
date: 2025-11-27 14:28:52
categories: 
  - 八股
  - Spring
---

## 为什么使用SpringBoot

* **简化开发**：Spring Boot通过提供一系列的开箱即用的组件和自动配置，简化了项目的配置和开发过程，开发人员可以更专注于业务逻辑的实现，而不需要花费过多时间在繁琐的配置上。
* **快速启动**：Spring Boot提供了快速的应用程序启动方式，可通过内嵌的Tomcat、Jetty或Undertow等容器快速启动应用程序，无需额外的部署步骤，方便快捷。
* **自动化配置**：Spring Boot通过自动配置功能，根据项目中的依赖关系和约定俗成的规则来配置应用程序，减少了配置的复杂性，使开发者更容易实现应用的最佳实践

## SpringBoot比Spring好在哪里

* Spring Boot 提供了**自动化配置**，大大简化了项目的配置过程。通过约定优于配置的原则，很多常用的配置可以自动完成，开发者可以专注于业务逻辑的实现。
* Spring Boot 提供了**快速的项目启动器**，通过引入不同的 Starter，可以快速集成常用的框架和库，极大地提高了开发效率。
* Spring Boot 默认集成了**多种内嵌服务器**（如Tomcat、Jetty、Undertow），无需额外配置，即可将应用打包成可执行的 JAR 文件，方便部署和运行。

## SpringBoot用到哪些设计模式？

代理模式：Spring 的 AOP 通过动态代理实现方法级别的切面增强，有静态和动态两种代理方式，采用动态代理方式。

* **策略模式**：Spring AOP 支持 JDK 和 Cglib 两种动态代理实现方式，通过策略接口和不同策略类，运行时动态选择，其创建一般通过工厂方法实现。
* **装饰器模式**：Spring 用 TransactionAwareCacheDecorator 解决缓存与数据库事务问题增加对事务的支持。
* **单例模式**：Spring Bean 默认是单例模式，通过单例注册表（如 HashMap）实现。
* **简单工厂模式**：Spring 中的 BeanFactory 是简单工厂模式的体现，通过工厂类方法获取 Bean 实
例。
* **工厂方法模式**：Spring中的 FactoryBean 体现工厂方法模式，为不同产品提供不同工厂。
* **观察者模式**：Spring 观察者模式包含 Event 事件、Listener 监听者、Publisher 发送者，通过定义事件、监听器和发送者实现，观察者注册在 ApplicationContext 中，消息发送由ApplicationEventMulticaster 完成。
* **模板模式**：Spring Bean 的创建过程涉及模板模式，体现扩展性，类似 Callback 回调实现方式。
* **适配器模式**：Spring MVC 中针对不同方式定义的 Controller，利用适配器模式统一函数定义，定义了统一接口 HandlerAdapter 及对应适配器类。

## 怎么理解SpringBoot中的约定大于配置

约定大于配置是Spring Boot的核心设计理念，它通过预设合理的默认行为和项目规范，大幅减少开发者需要手动配置的步骤，从而提升开发效率和项目标准化程度。

* **自动化配置**：Spring Boot 提供了大量的自动化配置，通过分析项目的依赖和环境，自动配置应用程序的行为。开发者无需显式地配置每个细节，大部分常用的配置都已经预设好了。例如，引入spring-boot-starter-web 后，Spring Boot会自动配置内嵌Tomcat和Spring MVC，无需手动编写XML。
* **默认配置**：Spring Boot 为诸多方面提供大量默认配置，如连接数据库、设置 Web 服务器、处理日志等。开发人员无需手动配置这些常见内容，框架已做好决策。例如，默认的日志配置可让应用程序快速输出日志信息，无需开发者额外繁琐配置日志级别、输出格式与位置等。
* **约定的项目结构**：Spring Boot 提倡特定项目结构，通常主应用程序类（含 main 方法）置于根包，控制器类、服务类、数据访问类等分别放在相应子包，如 com.example.demo.controller 放控制器类， com.example.demo.service 放服务类等。此约定使团队成员更易理解项目结构与组织，新成员加入项目时能快速定位各功能代码位置，提升协作效率

## SpringBoot的项目结构是怎么样的？

* 开放接口层：可直接封装 Service 接口暴露成 RPC 接口；通过 Web 封装成 http 接口；网关控制层等。
* 终端显示层：各个端的模板渲染并执行显示的层。当前主要是 velocity 渲染，JS 渲染，JSP 渲染，
移动端展示等。
* Web 层：主要是对访问控制进行转发，各类基本参数校验，或者不复用的业务简单处理等。
* Service 层：相对具体的业务逻辑服务层。
* Manager 层：通用业务处理层，它有如下特征：
  * 对第三方平台封装的层，预处理返回结果及转化异常信息，适配上层接口。
  * 对 Service 层通用能力的下沉，如缓存方案、中间件通用处理。
  * 与 DAO 层交互，对多个 DAO 的组合复用。
* DAO 层：数据访问层，与底层 MySQL、Oracle、Hbase、OceanBase 等进行数据交互。
* 第三方服务：包括其它部门 RPC 服务接口，基础平台，其它公司的 HTTP 接口，如淘宝开放平台、支付宝付款服务、高德地图服务等。
* 外部接口：外部（应用）数据存储服务提供的接口，多见于数据迁移场景中。

## 什么是自动装配？

SpringBoot 的自动装配原理是基于Spring Framework的条件化配置和@EnableAutoConfiguration注解实现的。这种机制允许开发者在项目中引入相关的依赖，SpringBoot 将根据这些依赖自动配置应用程序的上下文和功能。

SpringBoot 在启动时会扫描外部引用 jar 包中的META-INF/spring.factories文件，将文件中配置的类型信息加载到 Spring 容器，并执行类中定义的各种操作。对于外部 jar 来说，只需要按照SpringBoot 定义的标准，就能将自己的功能装置进SpringBoot。

通俗来讲，自动装配就是通过注解或一些简单的配置就可以在SpringBoot的帮助下开启和配置各种功能，比如数据库访问、Web开发。

## SpringBoot自动装配原理是什么？

`AutoConfigurationImportSelector` 是 `Spring Boot` 中一个重要的类，它实现了 `ImportSelector` 接口，用于实现自动配置的选择和导入。具体来说，它通过分析项目的类路径和条件来决定应该导入哪些自动配置类。

* **扫描类路径**: 在应用程序启动时， AutoConfigurationImportSelector 会扫描类路径上的 META-INF/spring.factories 文件，这个文件中包含了各种 Spring 配置和扩展的定义。在这里，它会查找所有实现了 AutoConfiguration 接口的类,具体的实现为 getCandidateConfigurations 方法。
* **条件判断**: 对于每一个发现的自动配置类， AutoConfigurationImportSelector 会使用条件判断机制来确定是否满足导入条件。这些条件可以是配置属性、类是否存在、Bean是否存在等等。
* **根据条件导入自动配置类**: 满足条件的自动配置类将被导入到应用程序的上下文中。这意味着它们会被实例化并应用于应用程序的配置。

## 说几个启动器（starter)？

* **spring-boot-starter-web**：这是最常用的起步依赖之一，它包含了Spring MVC和Tomcat嵌入式服务器，用于快速构建Web应用程序。
* **spring-boot-starter-security**：提供了Spring Security的基本配置，帮助开发者快速实现应用的安全性，包括认证和授权功能。
* **mybatis-spring-boot-starter**：这个Starter是由MyBatis团队提供的，用于简化在Spring Boot应用中集成MyBatis的过程。它自动配置了MyBatis的相关组件，包括SqlSessionFactory、MapperScannerConfigurer等，使得开发者能够快速地开始使用MyBatis进行数据库操作。
* **spring-boot-starter-data-jpa** 或 spring-boot-starter-jdbc：如果使用的是Java Persistence API (JPA)进行数据库操作，那么应该使用spring-boot-starter-data-jpa。这个Starter包含了Hibernate等JPA实现以及数据库连接池等必要的库，可以让你轻松地与MySQL数据库进行交互。你需要在application.properties或application.yml中配置MySQL的连接信息。如果倾向于直接使用JDBC而不通过JPA，那么可以使用spring-boot-starter-jdbc，它提供了基本的JDBC支持。
* **spring-boot-starter-data-redis**：用于集成Redis缓存和数据存储服务。这个Starter包含了与Redis交互所需的客户端，以及Spring DataRedis的支持，使得在Spring Boot应用中使用Redis变得非常便捷。同样地，需要在配置文件中设置Redis服务器的连接详情。
* **spring-boot-starter-test**：包含了单元测试和集成测试所需的库，如JUnit, Spring Test, AssertJ等，便于进行测试驱动开发(TDD)

## 写过SpringBoot starter吗?

* **步骤1-创建Maven项目**:首先，需要创建一个新的Maven项目。在pom.xml中添加Spring Boot的starter parent和一些必要的依赖。
* **步骤2-添加自动配置**:在src/main/resources/META-INF/spring.factories中添加自动配置的元数据。
* **步骤3-创建一个配置属性类**，使用`@ConfigurationProperties`注解来绑定配置文件中的属性。
* **步骤4-创建服务和控制器**：创建一个服务类和服务实现类，以及一个控制器来展示你的starter的功能
* **步骤5-发布Starter**：将你的starter发布到Maven仓库
* **步骤6-使用Starter**：在你的主应用的pom.xml中添加你的starter依赖，然后在application.yml中配置你的属性。

## SpringBoot里面有哪些重要的注解？还有一个配置相关的注解是哪个？

Spring Boot 中一些常用的注解包括：

* **@SpringBootApplication**：用于标注主应用程序类，标识一个Spring Boot应用程序的入口点，
同时启用自动配置和组件扫描。
* **@Controller**：标识控制器类，处理HTTP请求。
* **@RestController**：结合@Controller和@ResponseBody，返回RESTful风格的数据。
* **@Service**：标识服务类，通常用于标记业务逻辑层。
* **@Repository**：标识数据访问组件，通常用于标记数据访问层。
* **@Component**：通用的Spring组件注解，表示一个受Spring管理的组件。
* **@Autowired**：用于自动装配Spring Bean。
* **@Value**：用于注入配置属性值。
* **@RequestMapping**：用于映射HTTP请求路径到Controller的处理方法。
* **@GetMapping、@PostMapping、@PutMapping、@DeleteMapping**：简化@RequestMapping的GET、POST、PUT和DELETE请求。

另外，一个与配置相关的重要注解是：

* **@Configuration**：用于指定一个类为配置类，其中定义的bean会被Spring容器管理。通常与@Bean配合使用，@Bean用于声明一个Bean实例，由Spring容器进行管理。

## springboot怎么开启事务？

在 Spring Boot 中开启事务非常简单，只需在服务层的方法上添加 @Transactional 注解即可。

## Springboot怎么做到导入就可以直接使用的？

这个主要依赖于自动配置、起步依赖和条件注解等特性。

* **起步依赖**:起步依赖是一种特殊的 Maven 或 Gradle 依赖，它将项目所需的一系列依赖打包在一起。开发者只需在项目中添加一个起步依赖，Maven 或 Gradle 就会自动下载并管理与之关联的所有依赖，避免了手动添加大量依赖的繁琐过程。
* **自动配置**:Spring Boot 的自动配置机制会根据类路径下的依赖和开发者的配置，自动创建和配置应用所需的Bean。它通过 @EnableAutoConfiguration 注解启用，该注解会触发 Spring Boot 去查找 META -INF /spring.factories 文件。spring.factories 文件中定义了一系列自动配置类，Spring Boot 会根据当前项目的依赖情况，选择合适的自动配置类进行加载。开发者可以通过自定义配置来覆盖自动配置的默认行为。如果开发者在 application.properties 中定义了特定的配置，或者在代码中定义了同名的 Bean，Spring Boot 会优先使用开发者的配置
* **条件注解**:条件注解用于控制 Bean 的创建和加载，只有在满足特定条件时，才会创建相应的 Bean。Spring Boot的自动配置类中广泛使用了条件注解，如 @ConditionalOnClass 、 @ConditionalOnMissingBean等。

## SpringBoot 过滤器和拦截器说一下？

在 Spring Boot 中，过滤器（Filter）和拦截器（Interceptor）是用于处理请求和响应的两种不同机制。

* **过滤器**是 Java Servlet 规范中的一部分，它可以对进入 Servlet 容器的请求和响应进行预处理和后处理。过滤器通过实现 javax.servlet.Filter 接口，并重写其中的 init 、 doFilter 和 destroy 方法来完成相应的逻辑。当请求进入 Servlet 容器时，会按照配置的顺序依次经过各个过滤器，然后再到达目标Servlet 或控制器；响应返回时，也会按照相反的顺序再次经过这些过滤器。
* **拦截器**是 Spring 框架提供的一种机制，它可以对控制器方法的执行进行拦截。拦截器通过实现HandlerInterceptor 接口，并重写其中的 preHandle 、postHandle 和 afterCompletion 方法来完成相应的逻辑。当请求到达控制器时，会先经过拦截器的preHandle 方法，如果该方法返回 true ，则继续执行后续的控制器方法和其他拦截器；在控制器方法执行完成后，会调用拦截器的 postHandle 方法；最后，在请求处理完成后，会调用拦截器的afterCompletion 方法

过滤器和拦截器的区别如下：

* **所属规范**：过滤器是 Java Servlet 规范的一部分，而拦截器是 Spring 框架提供的机制。
* **执行顺序**：过滤器在请求进入 Servlet 容器后，在到达目标 Servlet 或控制器之前执行；拦截器在请求到达控制器之后，在控制器方法执行前后执行。
* **使用范围**：过滤器可以对所有类型的请求进行过滤，包括静态资源请求；拦截器只能对 Spring MVC 控制器的请求进行拦截。
* **功能特性**：过滤器主要用于对请求和响应进行预处理和后处理，如字符编码处理、请求日志记录等；拦截器可以更细粒度地控制控制器方法的执行，如权限验证、性能监控等。