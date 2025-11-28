---
title: "List-Set"  
date: 2025-11-28 00:00:00
categories: 
  - 八股
  - Java集合
---


## 数组与集合区别，用过哪些?

数组和集合的区别:

- 数组是固定长度的数据结构，一旦创建长度就无法改变，而集合是动态长度的数据结构，可以根据需动态增加或减少元素。
- 数组可以包含基本数据类型和对象，而**集合只能包含对象**。
- 数组可以直接访问元素，而集合需要通过迭代器或其他方法访问元素。

我用过的一些 Java 集合类：

1. **ArrayList**：动态数组，实现了List接口，支持动态增长。
2. **LinkedList**：双向链表，也实现了List接口，支持快速的插入和删除操作。
3. **HashMap**：基于哈希表的Map实现，存储键值对，通过键快速查找值。
4. **HashSet**：基于HashMap实现的Set集合，用于存储唯一元素。
5. **TreeMap**：基于红黑树实现的有序Map集合，可以按照键的顺序进行排序。
6. **LinkedHashMap**：基于哈希表和双向链表实现的Map集合，保持插入顺序或访问顺序。
7. **PriorityQueue**：优先队列，可以按照比较器或元素的自然顺序进行排序。

## 说说Java中的集合

List是有序的Collection，使用此接口能够精确的控制每个元素的插入位置，用户能根据索引访问List中元素。常用的实现List的类有LinkedList，ArrayList，Vector，Stack。

- **ArrayList**是容量可变的**非线程安全列表**，其底层使用数组实现。当几何扩容时，会创建更大的数组，并把原数组复制到新数组。ArrayList支持对元素的快速随机访问，但插入与删除速度很慢。
- **LinkedList**本质是一个双向链表，与ArrayList相比，其插入和删除速度更快，但随机访问速度更慢。

Set不允许存在重复的元素，与List不同，set中的元素是**无序**的。常用的实现有HashSet，LinkedHashSet和TreeSet。

- **HashSet**通过HashMap实现，HashMap的Key即HashSet存储的元素，所有Key都是用相同的Value，一个名为PRESENT的Object类型常量。使用Key保证元素唯一性，但不保证有序性。由于HashSet是HashMap实现的，因此**线程不安全**。
- **LinkedHashSet**继承自HashSet，通过LinkedHashMap实现，使用双向链表维护元素插入顺序。
- **TreeSet**通过TreeMap实现的，添加元素到集合时按照比较规则将其插入合适的位置，保证插入后的集合仍然有序。

Map是一个键值对集合，存储键、值和之间的映射。Key无序，唯一；value不要求有序，允许重复。Map没有继承于Collection接口，从Map集合中检索元素时，只要给出键对象，就会返回对应的值对象。主要实现有TreeMap、HashMap、HashTable、LinkedHashMap、ConcurrentHashMap

- **HashMap**：JDK1.8 之前 HashMap 由数组+链表组成的，数组是 HashMap 的主体，链表则是主要为了解决哈希冲突而存在的（“拉链法”解决冲突），JDK1.8 以后在解决哈希冲突时有了较大的变化，当链表长度大于阈值（默认为8）时，将链表转化为红黑树，以减少搜索时间
- **LinkedHashMap**：LinkedHashMap 继承自 HashMap，所以它的底层仍然是基于拉链式散列结构即由数组和链表或红黑树组成。另外，LinkedHashMap 在上面结构的基础上，增加了一条双向链表，使得上面的结构可以保持键值对的插入顺序。同时通过对链表进行相应的操作，实现了访问顺序相关逻辑。
- **HashTable**：数组+链表组成的，数组是 HashTable 的主体，链表则是主要为了解决哈希冲突而存在的
- **TreeMap**：红黑树（自平衡的排序二叉树）
- **ConcurrentHashMap**：Node数组+链表+红黑树实现，线程安全的（jdk1.8以前Segment锁，1.8以后volatile + CAS 或者 synchronized）

## Java中的线程安全的集合是什么？

在java.util包中的线程安全的类主要2个，其他都是非线程安全的。

- **Vector**：线程安全的动态数组，其内部方法基本都经过synchronized修饰，如果不需要线程安全，并不建议选择，毕竟同步是有额外开销的。Vector内部是使用对象数组来保存数据，可以根据需要自动的增加容量，当数组已满时，会创建新的数组，并拷贝原有数组数据。
- **Hashtable**：线程安全的哈希表，HashTable的加锁方法是给每个方法加上synchronized关键字，这样锁住的是整个Table对象，不支持null键和值，由于同步导致的性能开销，所以已经很少被推荐使用，如果要保证线程安全的哈希表，可以用ConcurrentHashMap。

java.util.concurrent包提供的都是线程安全的集合：

### 并发Map

- **ConcurrentHashMap**：它与HashTable的主要区别是二者加锁粒度的不同，在JDK1.7，ConcurrentHashMap加的是分段锁，也就是Segment锁，每个Segement含有整个table的一部分，这样不同分段之间的并发操作就互不影响。在JDK 1.8，它取消了Segment字段，直接在table元素上加锁，实现对每一行进行加锁，进一步减小了并发冲突的概率。对于put操作，如果Key对应的数组元素为null，则通过CAS操作（Compare and Swap）将其设置为当前值。如果Key对应的数组元素（也即链表表头或者树的根元素）不为null，则对该元素使用synchronized关键字申请锁，然后进行操作。如果该put操作使得当前链表长度超过一定阈值，则将该链表转换为红黑树，从而提高寻址效率。
- **ConcurrentSkipListMap**：实现了一个基于SkipList（跳表）算法的可排序的并发集合，SkipList是一种可以在对数预期时间内完成搜索、插入、删除等操作的数据结构，通过维护多个指向其他元素的“跳跃”链接来实现高效查找。

### 并发Set

- **ConcurrentSkipListSet**：是线程安全的有序的集合。底层是使用ConcurrentSkipListMap实现。
- **CopyOnWriteArraySet**：是线程安全的Set实现，它是线程安全的无序的集合，可以将它理解成线程安全的HashSet。有意思的是，CopyOnWriteArraySet和HashSet虽然都继承于共同的父类AbstractSet；但是，HashSet是通过“散列表”实现的，而CopyOnWriteArraySet则是通过“动态数组（CopyOnWriteArrayList）”实现的，并不是散列表。

### 并发List

- **CopyOnWriteArrayList**：它是 ArrayList 的线程安全的变体，其中所有写操作（add，set等）都通过对底层数组进行全新复制来实现，允许存储null 元素。即当对象进行写操作时，使用了Lock锁做同步处理，内部拷贝了原数组，并在新数组上进行添加操作，最后将新数组替换掉旧数组；若进行的读操作，则直接返回结果，操作过程中不需要进行同步。

### 并发Queue

- **ConcurrentLinkedQueue**：是一个适用于高并发场景下的队列，它通过无锁的方式(CAS)，实现了高并发状态下的高性能。通常，ConcurrentLinkedQueue 的性能要好于 BlockingQueue。
- **BlockingQueue**：与 ConcurrentLinkedQueue 的使用场景不同，BlockingQueue 的主要功能并不是在于提升高并发时的队列性能，而在于简化多线程间的数据共享。BlockingQueue 提供一种读写阻塞等待的机制，即如果消费者速度较快，则 BlockingQueue 则可能被清空，此时消费线程再试图从BlockingQueue 读取数据时就会被阻塞。反之，如果生产线程较快，则 BlockingQueue 可能会被装满，此时，生产线程再试图向 BlockingQueue 队列装入数据时，便会被阻塞等待。

### 并发Deque

- **LinkedBlockingDeque**：是一个线程安全的双端队列实现。它的内部使用链表结构，每一个节点都维护了一个前驱节点和一个后驱节点。LinkedBlockingDeque 没有进行读写锁的分离，因此同一时间只能有一个线程对其进行操作
- **ConcurrentLinkedDeque**：ConcurrentLinkedDeque是一种基于链接节点的无限并发链表。可以安全地并发执行插入、删除和访问操作。当许多线程同时访问一个公共集合时，ConcurrentLinkedDeque是一个合适的选择。

## Collections和Collection的区别

- **Collection**是Java集合框架中的一个接口，它是所有集合类的基础接口。它定义了一组通用的操作和方法，如添加、删除、遍历等，用于操作和管理一组对象。Collection接口有许多实现类，如List、Set和Queue等。
- **Collections**是Java提供的一个工具类，位于java.util包中。它提供了一系列静态方法，用于对集合进行操作和算法。Collections类中的方法包括排序、查找、替换、反转、随机化等等。这些方法可以对实现了Collection接口的集合进行操作，如List和Set。

## 集合遍历的方法有哪些？

在Java中，集合的遍历方法主要有以下几种：

- **普通for循环**：可以使用带有索引的普通for循环来遍历List。
- **增强for循环（for-each循环）**：用于循环访问数组或集合中的元素。
- **Iterator迭代器**：可以使用迭代器来遍历集合，特别适用于需要删除元素的情况。
- **ListIterator 列表迭代器**：ListIterator是迭代器的子类，可以双向访问列表并在迭代过程中修改元素。
- **使用 forEach 方法**：Java 8引入了forEach 方法，可以对集合进行快速遍历。
- **Stream API**:Java 8的Stream API提供了丰富的功能，可以对集合进行函数式操作，如过滤、映射等

## Set集合有什么特点？如何实现key无重复的？

- **set集合特点**：Set集合中的元素是唯一的，不会出现重复的元素。
- **set实现原理**：Set集合通过内部的数据结构（如哈希表、红黑树等）来实现key的无重复。当向Set集合中插入元素时，会先根据元素的hashCode值来确定元素的存储位置，然后再通过equals方法来判断是否已经存在相同的元素，如果存在则不会再次插入，保证了元素的唯一性。

## 有序的Set是什么？记录插入顺序的集合是什么？

- **有序的Set**是TreeSet和LinkedHashSet。TreeSet是基于红黑树实现，保证元素的自然顺序。LinkedHashSet是基于双重链表和哈希表的结合来实现元素的有序存储，保证元素添加的自然顺序
- **记录插入顺序的集合**通常指的是LinkedHashSet，它不仅保证元素的唯一性，还可以保持元素的插入顺序。当需要在Set集合中记录元素的插入顺序时，可以选择使用LinkedHashSet来实现。

## 常见的List集合

非线程安全List:

- **ArrayList** 基于动态数组实现，它允许快速的随机访问，即通过索引访问元素的时间复杂度为O(1)。在添加和删除元素时，如果操作位置不是列表末尾，可能需要移动大量元素，性能相对较低。适用于需要频繁随机访问元素，而对插入和删除操作性能要求不高的场景，如数据的查询和展示等。
- **LinkedList** 基于双向链表实现，在插入和删除元素时，只需修改链表的指针，不需要移动大量元素，时间复杂度为O(1)。但随机访问元素时，需要从链表头或链表尾开始遍历，时间复杂度为O(n)。适用于需要频繁进行插入和删除操作的场景，如队列、栈等数据结构的实现，以及需要在列表中间频繁插入和删除元素的情况。

线程安全List:

- **Vector** 和 ArrayList 类似，也是基于数组实现。Vector 中的方法大多是同步的，这使得它在多线程环境下可以保证数据的一致性，但在单线程环境下，由于同步带来的开销，性能会略低于ArrayList。
- **CopyOnWriteArrayList** 在对列表进行修改（如添加、删除元素）时，会创建一个新的底层数组，将修改操作应用到新数组上，而读操作仍然在原数组上进行，这样可以保证读操作不会被写操作阻塞，实现了读写分离，提高了并发性能。适用于读操作远远多于写操作的并发场景，如事件监听列表等，在这种场景下可以避免大量的锁竞争，提高系统的性能和响应速度。

## list如何快速删除某个指定下标的元素？

**ArrayList** 提供了 remove(int index) 方法来删除指定下标的元素，该方法在删除元素后，会将后续元素向前移动，以填补被删除元素的位置。如果删除的是列表末尾的元素，时间复杂度为 O(1)；如果删除的是列表中间的元素，时间复杂度为 O(n)，n 为列表中元素的个数，因为需要移动后续的元素。

**LinkedList** 的 remove(int index) 方法也可以用来删除指定下标的元素。它需要先遍历到指定下标位置，然后修改链表的指针来删除元素。时间复杂度为 O(n)，n 为要删除元素的下标。不过，如果已知要删除的元素是链表的头节点或尾节点，可以直接通过修改头指针或尾指针来实现删除，时间复杂度为 O(1)。

**CopyOnWriteArrayList** 的 remove 方法同样可以删除指定下标的元素。由于 CopyOnWriteArrayList 在写操作时会创建一个新的数组，所以删除操作的时间复杂度取决于数组的复制速度，通常为 O(n)，n 为数组的长度。但在并发环境下，它的删除操作不会影响读操作，具有较好的并发性能。

## 讲一下java里面list的几种实现，几种实现有什么不同？

在Java中，List 接口是最常用的集合类型之一，用于存储元素的有序集合。以下是Java中常见的 List 实现及其特点：

- **Vector**：是 Java 早期提供的线程安全的动态数组，如果不需要线程安全，并不建议选择，毕竟同步是有额外开销的。Vector 内部是使用对象数组来保存数据，可以根据需要自动的增加容量，当数组已满时，会创建新的数组，并拷贝原有数组数据。
- **ArrayList**：是应用更加广泛的动态数组实现，它本身不是线程安全的，所以性能要好很多。与 Vector 近似，ArrayList 也是可以根据需要调整容量，不过两者的调整逻辑有所区别，Vector 在扩容时会提高 1 倍，而 ArrayList 则是增加 50%。
- **LinkedList**：顾名思义是 Java 提供的双向链表，所以它不需要像上面两种那样调整容量，它也不是线程安全的。

这几种实现具体在什么场景下应该用哪种？

- **Vector 和 ArrayList** 作为动态数组，其内部元素以数组形式顺序存储的，所以非常适合**随机访问**的场合。除了尾部插入和删除元素，往往性能会相对较差，比如我们在中间位置插入一个元素，需要移动后续所有元素。
- **LinkedList** 进行节点**插入、删除**却要高效得多，但是随机访问性能则要比动态数组慢。

## ArrayList和LinkedList的区别，哪个集合是线程安全的？

ArrayList和LinkedList都是Java中常见的集合类，它们都实现了List接口。

- **底层数据结构不同**：ArrayList使用数组实现，通过索引进行快速访问元素。LinkedList使用链表实现，通过节点之间的指针进行元素的访问和操作。
- **插入和删除操作的效率不同**：ArrayList在尾部的插入和删除操作效率较高，但在中间或开头的插入和删除操作效率较低，需要移动元素。LinkedList在任意位置的插入和删除操作效率都比较高，因为只需要调整节点之间的指针，但是LinkedList是不支持随机访问的，所以除了头结点外插入和删除的时间复杂度都是O(n)，效率也不是很高所以LinkedList基本没人用。
- **随机访问的效率不同**：ArrayList支持通过索引进行快速随机访问，时间复杂度为O(1)。LinkedList需要从头或尾开始遍历链表，时间复杂度为O(n)。
- **空间占用**：ArrayList在创建时需要分配一段连续的内存空间，因此会占用较大的空间。LinkedList每个节点只需要存储元素和指针，因此相对较小。
- **使用场景**：ArrayList适用于频繁随机访问和尾部的插入删除操作，而LinkedList适用于频繁的中间插入删除操作和不需要随机访问的场景。
- **线程安全**：这两个集合都不是线程安全的，Vector是线程安全的

## ArrayList 和 LinkedList 的应用场景？

- ArrayList适用于需要频繁访问集合元素的场景。它基于数组实现，可以通过索引快速访问元素，因此在按索引查找、遍历和随机访问元素的操作上具有较高的性能。当需要频繁访问和遍历集合元素，并且集合大小不经常改变时，推荐使用ArrayList
- LinkedList适用于频繁进行插入和删除操作的场景。它基于链表实现，插入和删除元素的操作只需要调整节点的指针，因此在插入和删除操作上具有较高的性能。当需要频繁进行插入和删除操作，或者集合大小经常改变时，可以考虑使用LinkedList。

## 为什么ArrayList不是线程安全的，具体来说是哪里不安全？

在高并发添加数据下，ArrayList会暴露三个问题：

- 部分值为null（我们并没有add null进去）
- 索引越界异常
- size与我们add的数量不符

为了知道这三种情况是怎么发生的，ArrayList，add增加元素的代码如下：

```java
public boolean add(E e) {
    ensureCapacityInternal(size + 1);  // Increments modCount!!
    elementData[size++] = e;
    return true;
}
```

ensureCapacityInternal()这个方法的详细代码我们可以暂时不看，它的作用就是判断如果将当前的新元素加到列表后面，列表的elementData数组的大小是否满足，如果size + 1的这个需求长度大于了elementData这个数组的长度，那么就要对这个数组进行扩容。

大体可以分为三步：

- 判断数组需不需要扩容，如果需要的话，调用grow方法进行扩容；
- 将数组的size位置设置值（因为数组的下标是从0开始的）；
- 将当前集合的大小加1

下面我们来分析三种情况都是如何产生的：

- **部分值为null**：当线程1走到了扩容那里发现当前size是9，而数组容量是10，所以不用扩容，这时候cpu让出执行权，线程2也进来了，发现size是9，而数组容量是10，所以不用扩容，这时候线程1继续执行，将数组下标索引为9的位置set值了，还没有来得及执行size++，这时候线程2也来执行了，又把数组下标索引为9的位置set了一遍，这时候两个先后进行size++，导致下标索引10的地方就为null了。
- **索引越界异常**：线程1走到扩容那里发现当前size是9，数组容量是10不用扩容，cpu让出执行权，线程2也发现不用扩容，这时候数组的容量就是10，而线程1 set完之后size++，这时候线程2再进来size就是10，数组的大小只有10，而你要设置下标索引为10的就会越界（数组的下标索引从0开始）；
- **size 与我们 add 的数量不符**：这个基本上每次都会发生，这个理解起来也很简单，因为 size++ 本身就不是原子操作，可以分为三步：获取 size 的值，将 size 的值加 1，将新的 size 值覆盖掉原来的，线程 1 和线程 2 拿到一样的 size 值加完了同时覆盖，就会导致一次没有加上，所以肯定不会与我们 add 的数量保持一致的；

## ArrayList线程安全吗？把ArrayList变成线程安全有哪些方法？

不是线程安全的，ArrayList变成线程安全的方式有：

- 使用Collections类的synchronizedList方法将ArrayList包装成线程安全的List：
```java
List<String> synchronizedList = Collections.synchronizedList(arrayList);
```
- 使用CopyOnWriteArrayList类代替ArrayList，它是一个线程安全的List实现：
```java
CopyOnWriteArrayList<String> copyOnWriteArrayList = new CopyOnWriteArrayList<>(arrayList);
```
- 使用Vector类代替ArrayList，Vector是线程安全的List实现：
```java
Vector<String> vector = new Vector<>(arrayList);
```

## ArrayList的扩容机制说一下

ArrayList在添加元素时，如果当前元素个数已经达到了内部数组的容量上限，就会触发扩容操作。

ArrayList的扩容操作主要包括以下几个步骤：

- 计算新的容量：一般情况下，新的容量会扩大为原容量的1.5倍（在JDK 10之后，扩容策略做了调整），然后检查是否超过了最大容量限制。
- 创建新的数组：根据计算得到的新容量，创建一个新的更大的数组。
- 将元素复制：将原来数组中的元素逐个复制到新数组中。
- 更新引用：将ArrayList内部指向原数组的引用指向新数组。
- 完成扩容：扩容完成后，可以继续添加新元素。

## CopyOnWriteArrayList是如何保证线程安全的

CopyOnWriteArrayList 的线程安全，核心是通过 “写时复制+ 独占锁 + volatile 可见性” 三者协同实现，核心思路是「读写分离」—— 写操作修改副本、读操作直接访问原数组，从根本上避免读写冲突，具体实现细节如下：

1. 写操作：独占锁 + 写时复制，保证写写安全：所有写操作都会通
   过 独占锁保证 “同一时间只有一个线程执行写操作”，避免多线程写导致的副本混乱，步骤如下：
    - **加独占锁**：写线程先获取独占锁，其他写线程会阻塞，直到锁释放；
    - **复制原数组**：创建一个比原数组大 1（add 操作）或容量相同的新数组，将原数组的所有元素复制到新数组中；
    - **修改新数组**：在新数组上完成添加、删除或修改操作
    - **替换数组引用**：将 CopyOnWriteArrayList 内部指向数组的引用（用 volatile 修饰）原子性地切换为新数组（这一步是原子操作，保证读线程能感知到数组更新）；
    - **释放独占锁**：写操作完成后释放锁，允许其他写线程竞争。
2. 读操作：volatile 可见性 + 无锁访问，保证读安全：所有读
   操作无需加锁，直接访问内部数组，安全性由 volatile 关键字保证：
    - **内部数组引用用 volatile 修饰**：当写操作完成新数组替换后，volatile 会保证新数组的引用立刻同步到主内存，所有读线程后续读取时，会直接从主内存获取最新的数组引用；
    - **读操作访问原数组**：由于写操作修改的是新数组副本，原数组在被替换前始终不变，因此读线程访问原数组时，不会遇到 “写一半” 的中间状态，数据始终是完整的。