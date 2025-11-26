---
title: "Spring"  
date: 2025-11-24 23:22:22
categories: 
  - 八股
  - Java基础
---

## spring的核心思想说说你的理解？

| 核心思想 | 解决的问题                     | 实现手段               | 典型应用场景                     |
| :------- | :----------------------------- | :--------------------- | :------------------------------- |
| IOC      | 对象创建与依赖管理的高耦合     | 容器管理Bean生命周期   | 动态替换数据库实现、服务组装     |
| DI       | 依赖关系的硬编码问题           | Setter/构造器/注解注入 | 注入数据源、服务层依赖DAO层      |
| AOP      | 横切逻辑分散在业务代码中       | 动态代理与切面配置     | 日志、事务、权限校验统一处理     |

## 讲一下IoC

IoC即控制反转,是面向对象编程中的一种设计原则，可以用来降低计算机代码之间的耦合度。通过控制反转，对象在被创建的时候，由系统的外部实体，将其所依赖的对象的**引用**传递进来，而不是系统内部进行对象的创建

控制反转常用的实现方式是**依赖注入**

## 什么是依赖注入（DI)

依赖注入是一种编程技巧，我们不通过new的方式在类内部创建依赖类的对象，而是将依赖类的对象在外部创建好后，通过构造函数，函数参数等方式传递（或注入）给类使用

## 如何理解控制反转

所谓控制，就是对象的创建、初始化、销毁

- 创建对象：原来是new一个，现在有Spring容器进行创建
- 初始化对象：原来是对象自己通过构造器或setter方法给依赖的对象赋值，现在由Spring容器自动注入
- 销毁对象：原来是直接给对象赋值为null或做一些销毁操作，现在是Spring容器管理生命周期负责销毁工作

反转：反转控制权，把控制权交给Spring,我们有对象的控制者变为被动控制者

## 如何设计SpringIoc,从哪些方面考虑

- Bean的生命周期:设计Bean的创建、初始化、销毁等生命周期管理机制，考虑工厂模式和单例模式
- 依赖注入：实现依赖注入的功能，如属性注入，构造函数注入，方法注入等，考虑使用反射和XML配置文件实现
- AOP支持：考虑使用动态代理和切面编程实现
- 异常处理：考虑Bean创建异常，依赖注入异常等
- 配置文件加载：支持从不同配置文件中加载Bean的相关信息，考虑XML,注解或者Java配置类实现

## IOC的实现机制是什么

- 反射：SpringIOC容器利用Java的反射机制动态地加载类、创建对象实例以及调用方法对象，反射允许在运行时检查类、方法、属性等信息，从而实现灵活的对象实例化和管理
- 依赖注入：Spring的核心概念
- 工厂模式：SpringIOC采用工厂模式来管理对象的创建和生命周期。容器作为工厂负责实例化Bean并管理他们的生命周期，将Bean的实例化过程交给容器来管理
- 容器实现：SpringIoC容器是实现IoC的核心，通常使用BeanFactory或ApplicationContext来管理Bean。BeanFactory是Ioc容器的基本形式，提供基本的IOC功能；ApplicationContext是BeanFactory的扩展，提供更多企业级功能

## 什么是AOP?

AOP:面向切面编程，能够将与业务无关，却为业务模块所共同调用的逻辑封装起来，以减少系统的重复代码，降低模块的耦合度。

SpringAOP是基于动态代理的，如果要代理的对象，实现了某个接口，那么SpringAOP就会使用JDKproxy，去创建代理对象，而对于没有实现接口的对象，就无法使用JDKproxy去进行代理，这时候SpringAOP会使用Cglib生成一个被代理对象的子类作为代理

## SpringAOP的实现机制

SpringAOP实现依赖于动态代理。

SpringAOP支持两种动态代理：

- **基于JDK的动态代理**：基于接口的动态代理，使用java.long.reflect.Proxy类和java.long.reflect.InVocationHandler接口实现。这种方法需要代理的类实现一个或多个接口。
- **基于CGLIB的动态代理**：基于类的动态代理，当被代理类没有实现接口时,Spring会使用CGLIB库生成一个被代理类的子类作为代理。CGLIB是一个第三方代码生成库，通过继承方式实现代理。

## 什么是动态代理

运行时动态生成对象，而不是在编译时。允许开发者在运行时指定要代理的接口和行为，从而在不修改源码的情况下增强方法的功能

## AOP内的概念

- **AspectJ**:切面，只是一个概念，没有具体的接口或类与之对应，是Join Point,Advice和Pointcut的统称
- **Join point**:连接点，指程序执行过程中的一个点，例如方法调用，异常处理等。在SpringAOP中仅支持方法级别的连接点
- **Advice**:通知，即我们定义的切面中的横切逻辑，有"around"，"brfore","after"三种类型。在很多AOP实现框架中，Advice通常作为一个拦截器，也可以包含多个拦截器作为一条链路围绕着JoinPoint进行处理
- **Pointcut**:切点，用于匹配连接点，一个Aspect包含哪些JoinPoint需要PointCut进行筛选
- **Introduction**：引介，它能够让切面为被通知的对象引入额外的接口和实现，即便被通知对象原本并未实现这些接口
- **Weaving**:织入，在切点的引导下，将通知逻辑插入到目标方法上，使得通知逻辑在方法调用时可以执行
- **AOP proxy**:指在AOP实现框架中实现切面协议的对象。在SpringAOP中两种代理：JDK,CGLIB
- **Target Object**:目标对象，即被代理的对象

## 什么是三级缓存

三级缓存指的是Spring在创建Bean的过程中，通过三级缓存来缓存正在创建的Bean,以及已经创建完成的Bean实例
通过三级缓存的机制，Spring能够在处理循环依赖时，确保及时暴露正在创建的Bean对象,并能够正确地注入已经初始化的Bean实例，从而解决循环依赖问题。

## 存储三级缓存的数据结构

都是 Map类型的缓存，比如Map {k:name; v:bean}。

- 一级缓存（singletonObjects）：这是一个Map类型的缓存，存储的是已经完全初始化好的bean，即完全准备好可以使用的bean实例。键是bean的名称，值是bean的实例。
- 二级缓存（earlySingletonObjects）：这同样是一个Map类型的缓存，存储的是早期的bean引用，即已经实例化但还未完全初始化的bean。这些bean已经被实例化，但是可能还没有进行属性注入等操作。
- 三级缓存（singletonFactories）：这也是一个Map类型的缓存，存储的是ObjectFactory对象，这些对象可以生成早期的bean引用。当一个bean正在创建过程中，如果它被其他bean依赖，那么这个正在创建的bean就会通过这个ObjectFactory来创建一个早期引用，从而解决循环依赖的问题。

## 循环依赖种类

- 第一种：通过构造方法进行依赖注入时产生的循环依赖问题
- 第二种：通过setter方法进行注入且是在多例模式下产生的循环依赖问题
- 第三种：通过setter方法进行注入且是在单例模式下产生的循环依赖问题
  
Spring只解决了第三种循环依赖问题

## 三级缓存步骤

- 首先从容器中获取A,获取不到然后创建实例,提前暴露添加到三级缓存中
- 进行依赖注入，从容器中获取B,获取不到，创建B，发现循环依赖，将B放入三级缓存
- 从三级缓存中发现A,将A从三级缓存中放入二级缓存然后注入B
- B创建完成，将B从三级缓存转移至一级缓存
- 继续进行A的依赖注入，注入B
- A依赖注入成功，初始化完成，添加到一级缓存
  
![8979ac65e61d689a34afaaa56a40633a_720](https://i-blog.csdnimg.cn/img_convert/a5a85d9cc6661b527e6608886167387b.jpeg)


## 如果只有一级缓存，能不能解决循环依赖问题？

不能。一级缓存存放的是完整的对象，如果只有一级缓存，意味着半成品的对象和完整的对象放在一起，这样getBean()可能会拿到半成品对象，属性值都是null。

## 如果只有一三级缓存，能不能解决循环依赖问题

能，但要求Bean没有被AOP进行切面代理
如果 Bean 被 AOP 代理，在创建过程中需要生成代理对象。而只有一三级缓存时，三级缓存中存放的工厂方法在创建 Bean 时无法正确处理 AOP 代理逻辑，可能导致生成的对象不是最终需要的代理对象，从而在循环依赖场景中出现问题。所以在这种情况下，无法解决有 AOP 代理的 Bean 的循环依赖问题。

## 为什么需要二级缓存

三级缓存singletonFactory中存放的是ObjectFactory,当执行getObject时每次都会产生一个新的代理对象，但是Bean是单例的，因此引入二级缓存，将对象放入二级缓存中之后直接去二级缓存中去而不必每次调用getObject获取新的代理对象

## spring三级缓存的数据结构是什么？

都是 Map类型的缓存，比如Map {k:name; v:bean}。

1. 一级缓存（Singleton Objects）：这是一个Map类型的缓存，存储的是已经完全初始化好的bean，即完全准备好可以使用的bean实例。键是bean的名称，值是bean的实例。这个缓存在DefaultSingletonBeanRegistry 类中的 singletonObjects 属性中。
2. 二级缓存（Early Singleton Objects）：这同样是一个Map类型的缓存，存储的是早期的bean引
用，即已经实例化但还未完全初始化的bean。这些bean已经被实例化，但是可能还没有进行属性
注入等操作。这个缓存在 DefaultSingletonBeanRegistry 类中的 earlySingletonObjects 属性
中。
3. 三级缓存（Singleton Factories）：这也是一个Map类型的缓存，存储的是ObjectFactory对象，这些对象可以生成早期的bean引用。当一个bean正在创建过程中，如果它被其他bean依赖，那么这个正在创建的bean就会通过这个ObjectFactory来创建一个早期引用，从而解决循环依赖的问题。这个缓存在 DefaultSingletonBeanRegistry 类中的 singletonFactories 属性中。

## spring框架中都用到了哪些设计模式

**工厂设计模式** : Spring使用工厂模式通过 BeanFactory、ApplicationContext 创建 bean 对象。
**代理设计模式** : Spring AOP 功能的实现。
**单例设计模式** : Spring 中的 Bean 默认都是单例的。
**模板方法模式** : Spring 中 jdbcTemplate、hibernateTemplate 等以 Template 结尾的对数据库操作的类，它们就使用到了模板模式。
**包装器设计模式** : 我们的项目需要连接多个数据库，而且不同的客户在每次访问中根据需要会去访问不同的数据库。这种模式让我们可以根据客户的需求能够动态切换不同的数据源。
**观察者模式**: Spring 事件驱动模型就是观察者模式很经典的一个应用。
**适配器模式** :Spring AOP 的增强或通知(Advice)使用到了适配器模式、spring MVC 中也是用到了适配器模式适配Controller。

## Spring的事务，使用this调用是否生效？

不能生效。
因为Spring事务是通过代理对象来控制的，只有通过代理对象的方法调用才会应用事务管理的相关规则。当使用 this 直接调用时，是绕过了Spring的代理机制，因此不会应用事务设置

## spring 常用注解有什么？

- **@Autowired 注解**：主要用于自动装配bean。当Spring容器中存在与要注入的属性**类型匹配**的bean时，它会自动将bean注入到属性中。就跟我们new 对象一样。
- **@Component**：这个注解用于标记一个类作为Spring的bean，并将其添加到Spring容器中。
- **@Configuration**，注解用于标记一个类作为Spring的配置类。配置类可以包含@Bean注解的方法，用于定义和配置bean，作为全局配置。
- **@Bean**注解用于标记一个方法作为Spring的bean工厂方法。当一个方法被@Bean注解标记时，Spring会将该方法的返回值作为一个bean，并将其添加到Spring容器中，如果自定义配置，经常用到这个注解。
- **@Service**，这个注解用于标记一个类作为服务层的组件。它@Component注解的特例，用于标记服务层的bean，一般标记在业务service的实现类。
- **@Repository**注解用于标记一个类作为数据访问层的组件。
- **@Controller**注解用于标记一个类作为控制层的组件。它也是@Component注解的特例，用于标记控制层的bean。这是MVC结构的另一个部分，加在控制层

## Spring的事务什么情况下会失效？

Spring Boot通过Spring框架的事务管理模块来支持事务操作。事务管理在Spring Boot中通常是通过@Transactional 注解来实现的。事务可能会失效的一些常见情况包括:

1. **未捕获异常**: 如果一个事务方法中发生了未捕获的异常，并且异常未被处理或传播到事务边界之外，
那么事务会失效，所有的数据库操作会回滚。
2. **非受检异常**: 默认情况下，Spring对非受检异常（RuntimeException或其子类）进行回滚处理，这意味着当事务方法中抛出这些异常时，事务会回滚。
3. **事务传播属性设置不当**: 如果在多个事务之间存在事务嵌套，且事务传播属性配置不正确，可能导致事务失效。特别是在方法内部调用有 @Transactional 注解的方法时要特别注意。
4. **多数据源的事务管理**: 如果在使用多数据源时，事务管理没有正确配置或者存在多个@Transactional 注解时，可能会导致事务失效。
5. **跨方法调用事务问题**: 如果一个事务方法内部调用另一个方法，而这个被调用的方法没有@Transactional 注解，这种情况下外层事务可能会失效。
6. **事务在非公开方法中失效**: 如果 @Transactional 注解标注在私有方法上或者非 public 方法上，事务也会失效。

## Bean的生命周期说一下？

1. Spring启动，查找并加载需要被Spring管理的bean，进行Bean的实例化
2. Bean实例化后对将Bean的引入和值注入到Bean的属性中
3. 如果Bean实现了BeanNameAware接口的话，Spring将Bean的Id传递给setBeanName()方法
4. 如果Bean实现了BeanFactoryAware接口的话，Spring将调用setBeanFactory()方法，将BeanFactory容器实例传入
5. 如果Bean实现了ApplicationContextAware接口的话，Spring将调用Bean的setApplicationContext()方法，将bean所在应用上下文引用传入进来。
6. 如果Bean实现了BeanPostProcessor接口，Spring就将调用他们的
postProcessBeforeInitialization()方法。
7. 如果Bean 实现了InitializingBean接口，Spring将调用他们的afterPropertiesSet()方法。类似的，如果bean使用init-method声明了初始化方法，该方法也会被调用
8. 如果Bean 实现了BeanPostProcessor接口，Spring就将调用他们的
postProcessAfterInitialization()方法。
9. 此时，Bean已经准备就绪，可以被应用程序使用了。他们将一直驻留在应用上下文中，直到应用上下文被销毁。
10. 如果bean实现了DisposableBean接口，Spring将调用它的destory()接口方法，同样，如果bean使用了destory-method 声明销毁方法，该方法也会被调用。

## Bean是否单例？

Spring 中的 Bean 默认都是单例的。
就是说，每个Bean的实例只会被创建一次，并且会被存储在Spring容器的缓存中，以便在后续的请求中重复使用。这种单例模式可以提高应用程序的性能和内存效率。
但是，Spring也支持将Bean设置为多例模式，即每次请求都会创建一个新的Bean实例。要将Bean设置为多例模式，可以在Bean定义中通过设置scope属性为"prototype"来实现。

## Bean的单例和非单例，生命周期是否一样

不一样的，Spring Bean 的生命周期完全由 IoC 容器控制。Spring 只帮我们管理单例模式 Bean 的完整
生命周期，对于 prototype 的 Bean，Spring 在创建好交给使用者之后，则不会再管理后续的生命周期

## Spring bean的作用域有哪些？

Spring框架中的Bean作用域（Scope）定义了Bean的生命周期和可见性。不同的作用域影响着Spring容器如何管理这些Bean的实例，包括它们如何被创建、如何被销毁以及它们是否可以被多个用户共享。

- **Singleton**（单例）：在整个应用程序中只存在一个 Bean 实例。默认作用域，Spring 容器中只会
创建一个 Bean 实例，并在容器的整个生命周期中共享该实例。
- **Prototype**（原型）：每次请求时都会创建一个新的 Bean 实例。次从容器中获取该 Bean 时都会
创建一个新实例，适用于状态非常瞬时的 Bean。
- **Request**（请求）：每个 HTTP 请求都会创建一个新的 Bean 实例。仅在 Spring Web 应用程序中
有效，每个 HTTP 请求都会创建一个新的 Bean 实例，适用于 Web 应用中需求局部性的 Bean。
- **Session**（会话）：Session 范围内只会创建一个 Bean 实例。该 Bean 实例在用户会话范围内共
享，仅在 Spring Web 应用程序中有效，适用于与用户会话相关的 Bean。
- **Application**：当前 ServletContext 中只存在一个 Bean 实例。仅在 Spring Web 应用程序中有效，该 Bean 实例在整个 ServletContext 范围内共享，适用于应用程序范围内共享的 Bean。
- **WebSocket**（Web套接字）：在 WebSocket 范围内只存在一个 Bean 实例。仅在支持WebSocket 的应用程序中有效，该 Bean 实例在 WebSocket 会话范围内共享，适用于 WebSocket会话范围内共享的 Bean。
- **Custom scopes**（自定义作用域）：Spring 允许开发者定义自定义的作用域，通过实现 Scope 接口来创建新的 Bean 作用域。

## Spring容器里存的是什么？

在Spring容器中，存储的主要是Bean对象。
Bean是Spring框架中的基本组件，用于表示应用程序中的各种对象。当应用程序启动时，Spring容器会根据配置文件或注解的方式创建和管理这些Bean对象。Spring容器会负责创建、初始化、注入依赖以及销毁Bean对象。

## 在Spring中，在bean加载/销毁前后，如果想实现某些逻辑，可以

- 使用init-method和destroy-method
- 使用@PostConstruct和@PreDestroy注解
- 实现InitializingBean和DisposableBean接口
- 使用@Bean注解的initMethod和destroyMethod属性

## Bean注入和xml注入最终得到了相同的效果，它们在底层是怎样做的

在Spring框架中，基于注解的Bean注入和基于XML的依赖注入虽然
在配置方式上不同，但在底层最终都通过Spring容器的统一机制实现依赖注入。

## XML 注入

使用 XML 文件进行 Bean 注入时，Spring 在启动时会读取 XML 配置文件，以下是其底层步骤：

- **Bean 定义解析**：Spring 容器通过 XmlBeanDefinitionReader 类解析 XML 配置文件，读取其中的 \<bean\> 标签以获取 Bean 的定义信息。注册 Bean 定义：解析后的 Bean 信息被注册到 BeanDefinitionRegistry （如DefaultListableBeanFactory ）中，包括 Bean 的类、作用域、依赖关系、初始化和销毁方法等。
- **实例化和依赖注入**：当应用程序请求某个 Bean 时，Spring 容器会根据已经注册的 Bean 定义：首先，使用反射机制创建该 Bean 的实例。
然后，根据 Bean 定义中的配置，通过 setter 方法、构造函数或方法注入所需的依赖 Bean。

## 注解注入

使用注解进行 Bean 注入时，Spring 的处理过程如下：

- **类路径扫描**：当 Spring 容器启动时，它首先会进行类路径扫描，查找带有特定注解的类。
- **注册 Bean 定义**：找到的类会被注册到 BeanDefinitionRegistry 中，Spring 容器将为其生成Bean 定义信息。这通常通过 AnnotatedBeanDefinitionReader 类来实现。
- **依赖注入**：与 XML 注入类似，Spring 在实例化 Bean 时，也会检查字段上是否有 @Autowired 、@Inject 或 @Resource 注解。如果有，Spring 会根据注解的信息进行依赖注入。

尽管使用的方式不同，但 XML 注入和注解注入在底层的实现机制是相似的，主要体现在以下几个方面：

1. **BeanDefinition**：无论是 XML 还是注解，最终都会生成 BeanDefinition 对象，并存储在同一个 BeanDefinitionRegistry 中。
2. **后处理器**：Spring 提供了多个 Bean 后处理器（如 AutowiredAnnotationBeanPostProcessor ），用于处理注解（如 @Autowired ）的依赖注入。对于 XML，Spring 也有相应的后处理器来处理 XML 配置的依赖注入。
3. **依赖查找**：在依赖注入时，Spring 容器会通过 ApplicationContext 中的 BeanFactory 方法来查找和注入依赖，无论是通过 XML 还是注解，都会调用类似的查找方法。

## Spring给我们提供了很多扩展点，这些有了解吗？

Spring框架提供了许多扩展点，使得开发者可以根据需求定制和扩展Spring的功能。以下是一些常用的扩展点：

1. **BeanFactoryPostProcessor**：允许在Spring容器实例化bean之前修改bean的定义。常用于修改bean属性或改变bean的作用域。
2. **BeanPostProcessor**：可以在bean实例化、配置以及初始化之后对其进行额外处理。常用于代理bean、修改bean属性等。
3. **PropertySource**：用于定义不同的属性源，如文件、数据库等，以便在Spring应用中使用。
4. **ImportSelector和ImportBeanDefinitionRegistrar**：用于根据条件动态注册bean定义，实现配置类的模块化。
5. **Spring MVC中的HandlerInterceptor**：用于拦截处理请求，可以在请求处理前、处理中和处理后执行特定逻辑。
6. **Spring MVC中的ControllerAdvice**：用于全局处理控制器的异常、数据绑定和数据校验。
7. **Spring Boot的自动配置**：通过创建自定义的自动配置类，可以实现对框架和第三方库的自动配置。
8. **自定义注解**：创建自定义注解，用于实现特定功能或约定，如权限控制、日志记录等。
