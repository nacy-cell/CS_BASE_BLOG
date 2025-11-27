---
title: "Spring"  
date: 2025-11-27 13:28:52
categories: 
  - 八股
  - Spring
---

## MVC分层介绍一下

MVC用一种业务逻辑、数据、界面显示分离的方法组织代码，将业务逻辑聚集到一个部件里面，在改进和个性化定制界面及用户交互的同时，不需要重新编写业务逻辑。

* **视图**(view)： 为用户提供使用界面，与用户直接进行交互。
* **模型**(model)： 代表一个存取数据的对象。它也可以带有逻辑，主要用于承载数据，并对用户提交请求进行计算的模块。模型分为两类，一类称为数据承载 Bean，一类称为业务处理Bean。所谓数据承载 Bean 是指实体类，专门为用户承载业务数据的；而业务处理 Bean 则是指Service 或 Dao 对象， 专门用于处理用户提交请求的。
* **控制器**(controller)： 用于将用户请求转发给相应的 Model 进行处理，并根据 Model 的计算结果向用户提供相应响应。它使视图与模型分离。

## 了解SpringMVC的处理流程吗？

![SpringMVC-2025-11-27-13-35-19](https://csbase-blog.oss-cn-beijing.aliyuncs.com/SpringMVC-2025-11-27-13-35-19.png)

1. 用户发送请求至前端控制器DispatcherServlet
2. DispatcherServlet收到请求调用处理器映射器HandlerMapping。
3. 处理器映射器根据请求url找到具体的处理器，生成处理器执行链HandlerExecutionChain(包括处理器对象和处理器拦截器)一并返回给DispatcherServlet。
4. DispatcherServlet根据处理器Handler获取处理器适配器HandlerAdapter执行HandlerAdapter处理一系列的操作，如：参数封装，数据格式转换，数据验证等操作
5. 执行处理器Handler(Controller，也叫页面控制器)。
6. Handler执行完成返回ModelAndView
7. HandlerAdapter将Handler执行结果ModelAndView返回到DispatcherServlet
8. DispatcherServlet将ModelAndView传给ViewReslover视图解析器
9. ViewReslover解析后返回具体View
10. DispatcherServlet对View进行**渲染视图**（即将模型数据model填充至视图中）。
11. DispatcherServlet**响应**用户

## Handlermapping 和 handleradapter有了解吗？

HandlerMapping：

* **作用**：HandlerMapping负责将请求映射到处理器（Controller）。
* **功能**：根据请求的URL、请求参数等信息，找到处理请求的 Controller。
* **类型**：Spring提供了多种HandlerMapping实现，如BeanNameUrlHandlerMapping、
RequestMappingHandlerMapping等。
* **工作流程**：根据请求信息确定要请求的处理器(Controller)。HandlerMapping可以根据URL、请求参数等规则确定对应的处理器。

HandlerAdapter：

* **作用**：HandlerAdapter负责调用处理器(Controller)来处理请求。
* **功能**：处理器(Controller)可能有不同的接口类型（Controller接口、HttpRequestHandler接口等），HandlerAdapter根据处理器的类型来选择合适的方法来调用处理器。
* **类型**：Spring提供了多个HandlerAdapter实现，用于适配不同类型的处理器。
* **工作流程**：根据处理器的接口类型，选择相应的HandlerAdapter来调用处理器。