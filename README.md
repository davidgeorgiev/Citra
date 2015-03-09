Нашата програма, създава html галерия по подадена директория, като папките са албумите в галерията. Създават се миниатюри за по-бързо зареждане на снимките. В конфигурационни файлове за всеки албум се съхранява основната информация за изображенията като например: адрес на файла, албум, височина, широчина, средно аритметичен цвят (за сортиране по цветове в последствие), дата, id и др. Като основната идея на проекта е готовата html галерия, която е напълно независима и работи сама за себе си, да се качва автоматично онлайн или снимките да се качват във facebook автоматично като се подреждат в съответния албум. Допълнителни възможности има опция за запазване на оригиналните снимки или не (копиране на снимките, които надвишават ограничението за височината на lightbox-а) Изчислява оставащото време за обработката, като взима средно аритметичното на предишните времена за порция и показва колко информация е записана има и lightbox за по-оптимално снимките се конвертират 3 пъти 1 - миниатюри 2 - квадрати за предварителния изглед (обложката на албумите) 3 - снимка за визуализация в lightbox-а Въведено е ограничение за пропорциите на снимките (по желание) В най-новата ни версия на Citra 1.3.5 има опция за сортиране по цвят и показване на най-актуалните снимки като обложка на албума

Най-нови подобрения във версия 1.4.5 (07.03.2015)
- оправен е бъга: на всяка първа страница от албум има по-малко от предвиденото или никакви картинки
- затворени са таговете на част от страниците, които не се затваряха
- оправени са обложките, които бяха объркани и сочеха към миниатюрите вместо към квадратните картинки поради което се получаваше преоразмеряване и беше много дразнещо
- програмата е разделена е на два скрипта: main.rb за създаване на базата данни и конфигурацията и create.rb за създаване на галерията от готовата база данни
- добавено е слайдшоу на java script за всички албуми включително и за касифицираните по цветове картинки
- добавено е логото на продукта
- добавена е опция за връщане на директориите в начално състояние clean.rb

Най-нови подобрения във версия 1.4.6 (08.03.2015)
- оправен е бъга при затварянето на html таговете при слайдшоуто с класираните по цветове изображения
- промених слайдшоуто като му добавих миниатюри за по-удобно използване и по-добър изглед
- добавям clean_g.rb, който да изчиства автоматично html галерията без да трие датабазата и конфигурациите
- спиъка с миниатюрите в слайдшоуто е сложен в scroll box за удобство
- снимките се конвертират и в 72px X 72px за по-оптимално при зареждане на миниатюрите в слайдшоуто 
- добавена е защита от евентуални бъгове при създаването на галерията
- опция за показване само на тези снимки, които са с подходящи дименсии в слайдшоуто
