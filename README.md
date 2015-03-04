# NFK 0.62b

Latest available source code of original Need For Kill game.

Game preview: http://www.youtube.com/watch?v=FgvgVttl0zE

More about Need For Kill: http://info.needforkill.ru

## HOWTO COMPILE NFK !? // НФК - ПЕРВОЕ ДЫХАНИЕ, Третье пришествие (18 января 2009 года)
(пост с форума http://needforkill.ru/forum/2-399-1)

Вобщем тут коротеничко опишу как инсталить и компилить сорсы НФК'и
Разобраться со всем этим мне помогал, а точнее описывал весь процесс exile, за что ему огромное спасибо !

Для начала требования:
1. Делфи 7 - самая обычная

2. Сами исходники 062B

3. Пакет PowerDraw

4. Хренатень dclsockets70.bpl

5. Срань FastNet.v5.6.3.D5-7.FS

6. Delphix D7 Директ X примочки

7. Мозг (рекомендуется) и куча свободного времени

Вобщем полагаю Делфи 7 у вас уже стоит, самое время СКАЧАТЬ ИСХОДНИКИ НФК (NFK)

Качаем NFK.SDK.Lite 62B~64 облегчённый вариант отсюда: https://github.com/NeedForKillTheGame/nfk062b/releases/download/062b/NFK-SDK-062B.rar
либо ломимся ко мне в асю и просим 40 Мегабайтный оригинал Повера. (Архив заблокирован паролем, пароль от архива могут получить далеко не все)

Вобщем так или иначе предположим, что каким-то способом вы завладели паролем к архиву
и дико стремитесь закодить чёнить в НФК, но всему своё время.

Теперь качаем пачку PowerДров, осюда https://github.com/NeedForKillTheGame/nfk062b/releases/download/062b/PowerDraw.zip

Ну вот одну небольшую мечту мы уже осуществили, мы УЖЕ завладели исходниками
и почти готовы начать процесс программирования, но для начала скачаем ещё одну
хреновину для нашего мега брутального проекта (FastNet.v5.6.3.D5-7.FS): https://github.com/NeedForKillTheGame/nfk062b/releases/download/062b/Hrenovina.rar

А за неё ещё и эту фуфлыгу, не менее важную предыдущих: https://github.com/NeedForKillTheGame/nfk062b/releases/download/062b/Delphix_d7.zip

Теперь самое время покурить тем кто курит, а кто не курит, пьём чай с бубликами

Ну а теперь, когда мы раздобыли всё чё нам нужно по шурику всё инсталим:

1) Открываем Делфи 7 Menu: Components -> Install Packages -> Кнопка ADD
-> C:\Program Files\Borland\Delphi7\Bin\dclsockets70.bpl

2) Распаковываем ПоверДров, открываем PowerDraw24pwr\Source\PowerGrafixD6.dpk тыкаем Install, тыкаем Save ALL
теперь из этой папки PowerDraw24pwr копируем всё содержимое в:
C:\Program Files\Borland\Delphi7\Lib\

3) Теперь распаковываем ту хреновину Hrenovina.rar, открываем FastNet.v5.6.3.D5-7.FS\Fastnet\lib\DCLNMF70.dpk,
жмем Install, опять жмем Save ALL, теперь опять всё содержимое FastNet.v5.6.3.D5-7.FS\Fastnet\lib\ копируем:
C:\Program Files\Borland\Delphi7\Lib\

4) НУ и на последок прикрутим DelphiX d7, распаковываем Dephix_d7.zip,
в папке Source запускаем Delphix_for7.dpk, жмем Install, Save All, содержимое этой папки также сливаем в
C:\Program Files\Borland\Delphi7\Lib\

Терь всё путём, можно компилить!

И Кто уже всё замутил может попытать удачю в фиксе первого бага - правая кнопка мыши и кнопка колёсико
мыши нфк чёта не воспринимает в остальном всё путём... Эксперты говорят истина где-то в DXINPUT...
У меня почемуто возник этот глюк, мож у других всё в норме... ТЕСТИМ !
