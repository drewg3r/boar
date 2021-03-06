# Boar. Запити зацікавлених осіб
 
## Зміст
   1. [Вступ](#l1)<br>
      1.1 [Мета](#l11)<br>
      1.2. [Контекст](#l12)<br>
      1.3. [Основні визначення та скорочення](#l13)<br>
   2. [Короткий зміст](#l2)<br>
   3. [Характеристика ділових процесів](#l3)<br>
   4. [Короткий огляд продукту](#l4)<br>
   5. [FURPS](#l5)<br>
      5.1. [Функціональність](#l51)<br>
      5.2. [Практичність](#l52)<br>
      5.3. [Надійність](#l53)<br>
      5.4. [Продуктивність](#l54)<br>
      5.5. [Експлуатаційна придатність](#l55)

   


## <a name="l1">1. Вступ</a>

У цьому документі описуються запити зацікавлених осіб (стрейкголдерів) стосовно розробляємої в рамках лабораторних робіт системи управління проєктами.

### <a name="l11">1.1. Мета</a>

Метою документа є визначення основних вимог до функціональності, практичності, надійності, продуктивності та експлуатаційної придатності, а також характеристика ділових процесів, факторів, що впливають на бізнес.

### <a name="l12">1.2. Контекст</a>

Перелік вимог, перерахованих в цьому документі, є основою технічного завдання на розробку системи управління проєктами "Boar".


### <a name="l13">1.3. Основні визначення та скорочення</a>
[Див. Аналіз предметної області](state-of-the-art.md#основні-визначення)


## <a name="l2">2. Короткий зміст</a>

Надалі розглянемо характеристику ділових процесів та FURPS.

## <a name="l3">3. Характеристика ділових процесів</a>


#### Категорії користувачів

|*Ім'я*|*Короткий опис*|*Характеристики*|*Взаємозв'язки*|
| ----- |  ------- | --------  | ---------|
|**Замовник**|Людина, що бажає замовити розробку системи для подальшого використання.|Здатний сформувати ідею та функцію системи.|Взаємодіє з проєктним менеджером.|
|**Менеджер проєкту**|Керівник проєкту. Займається отриманням та опрацюванням замовлення, передає його керівнику групи, контролює через керівника групи етапи розробки системи, а також реагує на всі побажання та запити замовника щодо системи.|Здатний контролювати велику кількість людей, організовувати етапи роботи та розподіляти завдання.|Взаємодіє з замовником та керівником групи.|
|**Керівник групи**|Керівник команди розробників. Займається розподілом завдань в команді, слідкує за ходом виконання і бере на себе відповідальність за технічну складову проєкту.|Висококваліфікований програміст, знає як керувати іншими програмістами та планувати задачі.|Взаємодіє з розробником, тестувальником та менеджером проєкту.|
|**Тестувальник**|Спеціаліст (або група спеціалістів), що після отримання від розробника (-ків) частину роботи, перевіряє її на наявність багів та  помилок.|Здатний знаходити помилки у коді, не залежно від його розміру та складності.|Взаємодіє з керівником групи та розробником.|
|**Розробник**|Спеціаліст (або група спеціалістів), котрий займається розробкою системи.|Здатний реалізувати будь-який проєкт від стадії задумки до її реалізації технічними засобами.|Взаємодіє з тестувальником та керівником групи.|

![buisness-use-cases](http://www.plantuml.com/plantuml/proxy?cache=no&src=https://raw.githubusercontent.com/drewg3r/boar/master/src/uml/buisness-use-cases.puml)

### Замовник

#### Сценарій №1

***ID:*** BC.001.001
       
***НАЗВА:*** Скласти/оновити технічне завдання

***УЧАСНИКИ:*** Замовник, менеджер проєкту

***ПЕРЕДУМОВИ:*** Менеджер проєкту продемонстрував незадовільну роботу; замовник знає, що саме хоче змінити

***РЕЗУЛЬТАТ:*** Менеджер проєкту отримав запит, сформоване ТЗ

***ВИКЛЮЧНІ СИТУАЦІЇ:***
 - EХ.001.001 Вимоги сформовані некоректно  

***ОСНОВНИЙ СЦЕНАРІЙ:*** 
1. Замовник висуває проєктному менеджеру свої вимоги.
2. Менеджер проєкту перевіряє умови замовника на коректність (можлива EХ.001.002).
3. Менеджер проєкту формує ТЗ з урахуванням нових умов замовника.
                       

### Менеджер проєкту

#### Сценарій №1

***ID:*** BC.002.001

***НАЗВА:*** Продемонструвати роботу замовнику

***УЧАСНИКИ:*** Менеджер проєкту, замовник

***ПЕРЕДУМОВИ:*** Завдання замовника виконано

***РЕЗУЛЬТАТ:*** Замовник проінформований щодо виконання завдання

***ВИКЛЮЧНІ СИТУАЦІЇ:*** 
 - EX.002.001: менеджер проєкту не задовільнений виконаною роботою.

***ОСНОВНИЙ СЦЕНАРІЙ:***
1. Менеджер проєкту переконується в коректності виконаної роботи(можливо EX.002.001);
2. Менеджер проєкту демонструє замовнику виконану роботу;
3. Замовник приймає роботу або вносить свої корективи(BC.001.001).

#### Сценарій №2

***ID:*** BC.002.002

***НАЗВА:*** Передати завдання керівнику групи

***УЧАСНИКИ:***  Менеджер проєкту, керівник групи

***ПЕРЕДУМОВИ:*** Сформовано ТЗ на основі вимог замовника

***РЕЗУЛЬТАТ:*** Керівник групи має ТЗ, стосовно якого дає завдання членам групи

***ВИКЛЮЧНІ СИТУАЦІЇ:*** відсутні

***ОСНОВНИЙ СЦЕНАРІЙ:*** Менеджер проєкту передає ТЗ до керівника групи

### Керівник групи

#### Сценарій 1

***ID:*** BC.003.001

***НАЗВА:*** Видати завдання розробнику

***УЧАСНИКИ:*** Керівник групи, розробник

***ПЕРЕДУМОВИ:*** Керівник групи отримав ТЗ від менеджера проєкту

***РЕЗУЛЬТАТ:*** Розробник має завдання для виконання

***ВИКЛЮЧНІ СИТУАЦІЇ:***
 - EX.003.001: Менеджер проєкту надав некоректне ТЗ.
                     
***ОСНОВНИЙ СЦЕНАРІЙ:***
1. Керівник групи читає ТЗ, яке сформував менеджер проєкту(можливо EX.003.001);
2. Керівник групи розбиває ТЗ на окремі задачі;
3. Керівник групи формує списки задач для кожного з розробників;
4. Керівник групи надсилає задачі розробникам.


#### Сценарій 2

***ID:*** BC.003.002

***НАЗВА:*** Відправити виконане завдання до менеджера проєкту

***УЧАСНИКИ:*** Керівник групи, менеджер проєкту

***ПЕРЕДУМОВИ:*** Команда керівника групи виконала завдання, керівник групи задоволений якістю виконання

***РЕЗУЛЬТАТ:*** Менеджер проєкту отримав виконану роботу для її подальшої демонстрації замовнику

***ВИКЛЮЧНІ СИТУАЦІЇ:*** відсутні
                     
***ОСНОВНИЙ СЦЕНАРІЙ:*** 
1. Керівник групи відправляє виконану роботу до менеджера проєкту;
2. Менеджер проєкту отримує виконану групою роботу.


#### Сценарій 3

***ID:*** BC.003.003

***НАЗВА:*** Повернути завдання розробнику через неякісне виконання

***УЧАСНИКИ:*** Керівник групи, розробник

***ПЕРЕДУМОВИ:*** Керівник групи отримав виконане розробником протестоване завдання

***РЕЗУЛЬТАТ:*** Розробник має завдання для перероблення

***ВИКЛЮЧНІ СИТУАЦІЇ:*** відсутні
                     
***ОСНОВНИЙ СЦЕНАРІЙ:***
1. Керівник групи переконався в неправильності виконання завдання;
2. Керівник групи формує список зауважень та недоліків до роботи;
3. Керівник групи повертає завдання до розробників зі списком зауважень та недоліків;
4. Розробники отримують завдання для перероблення.


### Тестувальник

#### Сценарій 1

***ID:*** BC.004.001

***НАЗВА:*** Повернути завдання до розробника

***УЧАСНИКИ:*** Тестувальник, розробник

***ПЕРЕДУМОВИ:*** Розробник надіслав завдання до тестувальника

***РЕЗУЛЬТАТ:*** Розробник має завдання для перероблення

***ВИКЛЮЧНІ СИТУАЦІЇ:***
 - EX.004.001: Помилок у роботі не знайдено.
                     
***ОСНОВНИЙ СЦЕНАРІЙ:***
1. Тестувальник тестує роботу розробника(можливо EX.004.001);
2. Тестувальник формує список зауважень та недоліків до роботи;
3. Тестувальник повертає завдання до розробника зі списком зауважень та недоліків;
4. Розробник отримує завдання для перероблення.


#### Сценарій 2

***ID:*** BC.004.002

***НАЗВА:*** Відправити завдання до керівника групи

***УЧАСНИКИ:*** Тестувальник, керівник групи

***ПЕРЕДУМОВИ:*** Розробник надіслав завдання до тестувальника

***РЕЗУЛЬТАТ:*** Керівник групи отримав виконане завдання розробника

***ВИКЛЮЧНІ СИТУАЦІЇ:***
 - EX.004.002: У роботі знайдена помилка(див [BC.004.001](#сценарій-1-3)).
                     
***ОСНОВНИЙ СЦЕНАРІЙ:***
1. Тестувальник тестує роботу розробника(можливо EX.004.001);
2. Тестувальник відправляє завдання до керівника групи;
3. Керівник групи отримав завдання.


### Розробник

#### Сценарій 1

***ID:*** BC.005.001

***НАЗВА:*** Перевірити список активних задач

***УЧАСНИКИ:*** Розробник

***ПЕРЕДУМОВИ:*** Розробник почав роботу

***РЕЗУЛЬТАТ:*** Розробник знає свої завдання

***ВИКЛЮЧНІ СИТУАЦІЇ:*** відсутні
                     
***ОСНОВНИЙ СЦЕНАРІЙ:*** Розробник дивиться у список своїх задач(що може бути не зовсім зручно)


#### Сценарій 2

***ID:*** BC.005.002

***НАЗВА:*** Відправити завдання до тестувальника

***УЧАСНИКИ:*** Розробник, тестувальник

***ПЕРЕДУМОВИ:*** Розробник виконав завдання

***РЕЗУЛЬТАТ:*** Тестувальник отримав виконане завдання розробника для перевірки

***ВИКЛЮЧНІ СИТУАЦІЇ:*** відсутні
                     
***ОСНОВНИЙ СЦЕНАРІЙ:***
1. Розробник переконується, що остаточно виконав завдання;
2. Розробник відправляє завдання до тестувальника;
3. Тестувальник отримав завдання.

## <a name="l4">4. Короткий огляд продукту</a>

**Boar** - це платформа(система) управління проєктами(*PMS - Project Management Software*), що допомагає організувати роботу в команді. Доступ до платформи здійснюється через *web-інтерфейс*, що являє собою низку таблиць(так званий канбан), у яких розподілені задачі для учасників проєкту. Учасники мають змогу взаємодіяти між собою за допомогою чату та інших можливостей для комунікації(згадка учасників проєкту в тексті задач, призначення відповідальних за задачі та ін.). Також **boar** надає деякі можливості для автоматизації робочого процесу, а саме, **boar** може бути інтегрований з системою контролю версій *GitHub*. 

## <a name="l5">5. FURPS</a>
FURPS - це класифікація вимог до програмного продукту. Далі розглядається кожний аспект цих вимог.


### <a name="l51">5.1. Функціональність</a>

#### 5.5.1. Інтерфейс розробника
Функціонування облікового запису розробника в системі має повною мірою задовільняти здійснення ділових процесів, [зазначених вище](#3-характеристика-ділових-процесів).
Для цього система має надавати наступні можливості:
 - Переглядати поточні невиконані завдання;
 - Змінювати статус виконання власних завдань(тобто відправляти на рев'ю до тестувальників);
 - Мати доступ до засобів зв'язку з командою.


#### 5.1.2. Інтерфейс тестувальника
Тестувальник повинен взаємодіяти з розробниками та керівником групи.
Система має дозволяти тестувальнику:
 - Переглядати завдання, які розробник відправив на рев'ю.
 - Змінювати статус завдань, що:
     - успішно пройшли рев'ю та відправляти їх до керівника групи,
     - не пройшли рев'ю та відправляти їх назад до розробника;
 - Мати доступ до засобів зв'язку з командою.

#### 5.1.3. Інтерфейс керівника групи
Для керівника групи важливо мати можливість контролювати всі процеси взаємодії учасників групи. Тому для керівника групи система надає **можливості інтерфейсів розробника та тестувальника +:**
 - Переглядати всі завдання всіх учасників групи;
 - Додавати завдання для розробників шляхом конкретизації більш абстрактних завдань від менеджеру проєкту.
 - Аналізувати роботу розробників та тестувальників -- виявляти невідповідність розробленого фрагмента проєкту до вимог ТЗ замовника, виявляти більш продуктивні зв'язки розробник+тестувальник.
 - Допомагати розробникам та тестувальникам(мати можливість змінювати статуси їх завдань);
 - Переглядати завдання менеджера проєкту.
 - Змінювати статус завдання менеджера проєкту(тобто доповідати йому про готовність виконання завдання);
 - Мати доступ до засобів зв'язку з командою та менеджером проєкту;

#### 5.1.4. Інтерфейс менеджера проєкту
Менеджер проєкту повинен бути забезпечений інструментами для взаємодії із керівниками груп та замовником.
Можливості:
 - Створювати нові завдання для керівників груп;
 - Мати доступ до засобів зв'язку з керівниками груп та замовником;
 - Демонструвати замовнику розроблений продукт(або його частину);

#### 5.1.5. Інтерфейс замовника
Існування інтерфейсу замовника в системі пов'язано з його бажанням контролювати та бачити статус розробки проєкту, а також з необхідністю постійно коректувати вектор розробки, що обумовлено agile-орієнтованістю системи.
Можливості:
 - Мати доступ до засобів зв'язку з менеджером проєкту;
 - Відстежувати прогрес розробки;



### <a name="l52">5.2. Практичність</a>

#### 5.2.1. User-friendly
Система буде досить доброзичливою в плані інтерфейсу. В якості елементів UI будуть використані стандартні компоненти, взаємодія з якими не повинна викликати труднощі у користувачів ПК. Меню та сторінки системи будуть логічно побудованими.

#### 5.2.2. Довідкова інформація
Система буде забезпечена короткою довідковою інформацією. Інструкції з інсталювання будуть викладені на офіційній сторінці проєкту на GitHub.

### <a name="l53">5.3. Надійність</a>

#### 5.3.1. Збої
Завдяки доволі простим алгоритмам, збої системи траплятимуться зовсім рідко та носитимуть легкий характер. Більшість збоїв будуть відбуватися через проблеми серверу(наприклад, закінчилося місце на диску, розрив інтернет з'єднання).
У результаті збою дані не будуть втрачені(за винятком щойно введених в браузері користувачем даних, що не були відправлені на сервер). З деякою періодичністю(в залежності від об'єму даних) буде відбуватися резервне копіювання.

#### 5.3.2. Доступність системи
Система повинна бути доступна 24 години на добу, або постійно. Оновлення ПЗ системи буде відбуватися з нульовим downtime'ом.

### <a name="l54">5.4. Продуктивність</a>

#### 5.4.1. Швидкість роботи
Швидкість роботи системи безпосередньо буде залежати від апаратури сервера та якості інтернет з'єднання. Слід зазначити, що система зможе працювати на практично будь-якому сучасному сервері. Стандартної швидкості інтернет з'єднання повинно вистачати для комфортної роботи із системою.

### <a name="l55">5.5. Експлуатаційна придатність</a>

#### 5.5.1. Розширюваність

**Boar** має бути здатною до подальшої підтримки після закінчення розробки, щоб мати змогу додавати нові функції та покращувати старі.

#### 5.5.2. Сумісність

**Boar** буде представлена у вигляді веб-сайту і доступна в браузері на будь-якому пристрої.

#### 5.5.3. Локалізація

**Boar** підлягатиме локалізації. Буде підтримувати три мови: українську, російську та англійську.
