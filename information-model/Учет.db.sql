BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "АктОремонте" (
	"ID_акта"	INTEGER,
	"Номеракта"	TEXT NOT NULL,
	"ID_ремонта"	INTEGER,
	"Датаакта"	DATE,
	"Признакинеисправности"	TEXT,
	"Выявленнаяпричина"	TEXT,
	"Переченьработ"	TEXT,
	PRIMARY KEY("ID_акта" AUTOINCREMENT),
	FOREIGN KEY("ID_ремонта") REFERENCES "Ремонт"("ID_ремонта")
);
CREATE TABLE IF NOT EXISTS "АктПриемки" (
	"ID_актаприемки"	INTEGER,
	"Номеракта"	TEXT NOT NULL,
	"Датаприемки"	DATE NOT NULL,
	"ID_поставщика"	INTEGER,
	"ID_оборудования"	INTEGER,
	"Инвентарныйномер"	TEXT,
	"Заключениекомиссии"	TEXT,
	"ID_ответственного"	INTEGER,
	PRIMARY KEY("ID_актаприемки" AUTOINCREMENT),
	FOREIGN KEY("ID_оборудования") REFERENCES "КарточкаУчетаИТСО"("ID_оборудования"),
	FOREIGN KEY("ID_ответственного") REFERENCES "Сотрудник"("ID_сотрудника"),
	FOREIGN KEY("ID_поставщика") REFERENCES "Поставщик"("ID_поставщика")
);
CREATE TABLE IF NOT EXISTS "АктСписания" (
	"ID_актасписания"	INTEGER,
	"Номеракта"	TEXT NOT NULL,
	"Датаактасписания"	DATE NOT NULL,
	"ID_оборудования"	INTEGER,
	"ID_протокола"	INTEGER,
	"Причинасписания"	TEXT,
	"ID_сотрудника"	INTEGER,
	"Заключение"	TEXT,
	PRIMARY KEY("ID_актасписания" AUTOINCREMENT),
	FOREIGN KEY("ID_оборудования") REFERENCES "КарточкаУчетаИТСО"("ID_оборудования"),
	FOREIGN KEY("ID_протокола") REFERENCES "ПротоколДиагностики"("ID_протокола"),
	FOREIGN KEY("ID_сотрудника") REFERENCES "Сотрудник"("ID_сотрудника")
);
CREATE TABLE IF NOT EXISTS "Должность" (
	"ID_должности"	INTEGER,
	"Название"	TEXT NOT NULL,
	"Описание"	TEXT,
	PRIMARY KEY("ID_должности" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "ЖурналКонтроля" (
	"ID_записи"	INTEGER,
	"Датаконтроля"	DATE NOT NULL,
	"ID_оборудования"	INTEGER,
	"Состояниеоборудования"	TEXT,
	"Описаниенеисправности"	TEXT,
	"ID_исполнителя"	INTEGER,
	"Датаисполнения"	DATE,
	"Выполненныеработы"	TEXT,
	PRIMARY KEY("ID_записи" AUTOINCREMENT),
	FOREIGN KEY("ID_исполнителя") REFERENCES "Сотрудник"("ID_сотрудника"),
	FOREIGN KEY("ID_оборудования") REFERENCES "КарточкаУчетаИТСО"("ID_оборудования")
);
CREATE TABLE IF NOT EXISTS "ЗаявкаНаПоставку" (
	"ID_заявки"	INTEGER,
	"Номерзаявки"	TEXT NOT NULL,
	"Датазаявки"	DATE NOT NULL,
	"ID_поставщика"	INTEGER,
	"Наименованиепозиции"	TEXT NOT NULL,
	"Количество"	INTEGER,
	"Требуемыйсрок"	DATE,
	"Статусзаявки"	TEXT,
	"Датастатуса"	DATE,
	PRIMARY KEY("ID_заявки" AUTOINCREMENT),
	FOREIGN KEY("ID_поставщика") REFERENCES "Поставщик"("ID_поставщика")
);
CREATE TABLE IF NOT EXISTS "ЗаявкаНаРемонт" (
	"ID_заявки"	INTEGER,
	"Номерзаявки"	TEXT NOT NULL,
	"Датазаявки"	DATE NOT NULL,
	"ID_записивЖК"	INTEGER,
	"Описаниенеисправности"	TEXT,
	"Статусзаявки"	TEXT,
	"Датастатуса"	DATE,
	"ID_заявителя"	INTEGER,
	PRIMARY KEY("ID_заявки" AUTOINCREMENT),
	FOREIGN KEY("ID_записивЖК") REFERENCES "ИТСО"("ID_оборудования")
);
CREATE TABLE IF NOT EXISTS "КарточкаУчетаИТСО" (
	"ID_оборудования"	INTEGER,
	"НаименованиеИТСО"	TEXT,
	"Серийныйномер"	TEXT,
	"Модель"	DATE,
	"Место_установки"	DATE,
	"Датаввода"	TEXT,
	"ID_актаприемки"	INTEGER,
	"ID_актасписания"	INTEGER,
	"Статусоборудования"	INTEGER,
	PRIMARY KEY("ID_оборудования" AUTOINCREMENT),
	FOREIGN KEY("ID_актаприемки") REFERENCES "АктПриемки"("ID_актаприемки"),
	FOREIGN KEY("ID_актасписания") REFERENCES "АктСписания"("ID_актасписания"),
	FOREIGN KEY("Статусоборудования") REFERENCES "СтатусОборудования"("Наименование")
);
CREATE TABLE IF NOT EXISTS "КонтактныеДанные" (
	"ID_контакта"	INTEGER,
	"Номертелефона"	INTEGER,
	"Email"	TEXT,
	PRIMARY KEY("ID_контакта" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "КонтрольныйЛистПоТО" (
	"ID_листа"	INTEGER,
	"ID_ТО"	INTEGER,
	"Номерлиста"	TEXT NOT NULL,
	"Датазаполнения"	DATE NOT NULL,
	"ID_исполнителя"	INTEGER,
	"Операция"	TEXT,
	"Норма"	TEXT,
	"Фактическоезначение"	TEXT,
	"Замечание"	TEXT,
	PRIMARY KEY("ID_листа" AUTOINCREMENT),
	FOREIGN KEY("ID_ТО") REFERENCES "ТО"("ID_ТО"),
	FOREIGN KEY("ID_исполнителя") REFERENCES "ТО"("ID_исполнителя")
);
CREATE TABLE IF NOT EXISTS "ОтчётПоТО" (
	"ID_отчета"	INTEGER,
	"Общийитог"	TEXT,
	"Заключение"	TEXT,
	PRIMARY KEY("ID_отчета" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "ОтчётПоремонту" (
	"ID_отчета"	INTEGER,
	"Общийрезультат"	TEXT,
	"Использованныематериалы"	TEXT,
	"Трудоемкость"	TEXT,
	PRIMARY KEY("ID_отчета" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "ПланГрафикТО" (
	"ID_плана"	INTEGER,
	"Номерплана"	BLOB,
	"Периодпланирования"	NUMERIC NOT NULL,
	"ID_оборудования"	INTEGER,
	"ДатапоследнегоТО"	DATE,
	"Плановаядата"	DATE NOT NULL,
	"Периодичность"	INTEGER,
	"Примечание"	TEXT,
	PRIMARY KEY("ID_плана" AUTOINCREMENT),
	FOREIGN KEY("ID_оборудования") REFERENCES "КарточкаУчетаИТСО"("ID_оборудования")
);
CREATE TABLE IF NOT EXISTS "Поставщик" (
	"ID_поставщика"	INTEGER,
	"Наименование"	TEXT NOT NULL,
	"Контактноелицо"	TEXT,
	"Телефон"	TEXT,
	"Email"	TEXT,
	PRIMARY KEY("ID_поставщика" AUTOINCREMENT),
	FOREIGN KEY("Email") REFERENCES "КонтактныеДанные"("Email"),
	FOREIGN KEY("Телефон") REFERENCES "КонтактныеДанные"("Номертелефона")
);
CREATE TABLE IF NOT EXISTS "ПротоколДиагностики" (
	"ID_протокола"	INTEGER,
	"Датадиагностики"	DATE NOT NULL,
	"Основание"	TEXT,
	"ID_исполнителя"	INTEGER,
	"Вывод"	TEXT,
	"ID_оборудования"	INTEGER,
	PRIMARY KEY("ID_протокола" AUTOINCREMENT),
	FOREIGN KEY("ID_исполнителя") REFERENCES "Сотрудник"("ID_сотрудника"),
	FOREIGN KEY("ID_оборудования") REFERENCES "КарточкаУчетаИТСО"("ID_оборудования")
);
CREATE TABLE IF NOT EXISTS "ПротоколПриемочныхИспытаний" (
	"ID_протокола"	INTEGER,
	"Номерпротокола"	TEXT NOT NULL,
	"Датаиспытаний"	DATE NOT NULL,
	"ID_оборудования"	INTEGER,
	"Результатыиспытаний"	TEXT NOT NULL,
	"Составкомиссии"	TEXT,
	PRIMARY KEY("ID_протокола" AUTOINCREMENT),
	FOREIGN KEY("ID_оборудования") REFERENCES "КарточкаУчетаИТСО"("ID_оборудования"),
	FOREIGN KEY("Составкомиссии") REFERENCES "Сотрудник"("ID_сотрудника")
);
CREATE TABLE IF NOT EXISTS "Ремонт" (
	"ID_ремонта"	INTEGER,
	"Номерремонта"	TEXT NOT NULL,
	"Названиеоборудования"	INTEGER,
	"Типремонта"	TEXT,
	"ID_заявки"	INTEGER,
	"Датаначала"	DATE,
	"Датаокончания"	DATE,
	"КраткоеОписаниеработ"	TEXT,
	"Причинаремонта"	TEXT,
	"ID_статусаремонта"	INTEGER,
	"ID_специалиста"	INTEGER,
	"ID_отчетаоремонте"	INTEGER,
	"ID_контрольноголиста"	INTEGER,
	"ID_исполнителя"	INTEGER,
	PRIMARY KEY("ID_ремонта" AUTOINCREMENT),
	FOREIGN KEY("ID_заявки") REFERENCES "ЗаявкаНаРемонт"("ID_заявки"),
	FOREIGN KEY("ID_исполнителя") REFERENCES "Сотрудник"("ID_сотрудника"),
	FOREIGN KEY("ID_контрольноголиста") REFERENCES "КонтрольныйЛистПоТО"("ID_листа"),
	FOREIGN KEY("ID_отчетаоремонте") REFERENCES "ОтчётПоремонту"("ID_отчета"),
	FOREIGN KEY("ID_специалиста") REFERENCES "СпециалистПодряднойОрганизации"("ID_специалиста"),
	FOREIGN KEY("ID_статусаремонта") REFERENCES "СтатусРемонтаиТО"("ID_статуса"),
	FOREIGN KEY("Названиеоборудования") REFERENCES "КарточкаУчетаИТСО"("НаименованиеИТСО"),
	FOREIGN KEY("Типремонта") REFERENCES "ТипРемонта"("Наименование")
);
CREATE TABLE IF NOT EXISTS "Сотрудник" (
	"ID_сотрудника"	INTEGER,
	"ФИО"	TEXT NOT NULL,
	"Отдел"	TEXT,
	"Квалификация"	TEXT,
	"Должность"	TEXT,
	"Телефон"	TEXT,
	PRIMARY KEY("ID_сотрудника" AUTOINCREMENT),
	FOREIGN KEY("Должность") REFERENCES "Должность"("Название"),
	FOREIGN KEY("Телефон") REFERENCES "ТелефонСотрудника"("Номертелефона")
);
CREATE TABLE IF NOT EXISTS "СпециалистПодряднойОрганизации" (
	"ID_специалиста"	INTEGER,
	"ФИО"	TEXT NOT NULL,
	"Телефон"	TEXT,
	"Квалификация"	TEXT,
	PRIMARY KEY("ID_специалиста" AUTOINCREMENT),
	FOREIGN KEY("Телефон") REFERENCES ""
);
CREATE TABLE IF NOT EXISTS "СтатусОборудования" (
	"ID_статуса"	INTEGER,
	"Наименование"	TEXT NOT NULL,
	PRIMARY KEY("ID_статуса" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "СтатусРемонтаиТО" (
	"ID_статуса"	INTEGER,
	"Наименование"	TEXT NOT NULL,
	PRIMARY KEY("ID_статуса" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "СтатусУведомления" (
	"ID_статусауведомления"	INTEGER,
	"Название"	TEXT,
	PRIMARY KEY("ID_статусауведомления" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "ТО" (
	"ID_ТО"	INTEGER,
	"НомерТО"	TEXT NOT NULL,
	"Плановаядата"	DATE NOT NULL,
	"Фактическаядата"	DATE,
	"ID_исполнителя"	INTEGER,
	"ID_статуса"	INTEGER,
	"ID_отчетпоТО"	INTEGER,
	"ID_планграфикаТО"	INTEGER,
	PRIMARY KEY("ID_ТО" AUTOINCREMENT),
	FOREIGN KEY("ID_исполнителя") REFERENCES "Сотрудник"("ID_сотрудника"),
	FOREIGN KEY("ID_отчетпоТО") REFERENCES "ОтчётПоТО"("ID_отчета"),
	FOREIGN KEY("ID_планграфикаТО") REFERENCES "ПланГрафикТО"("ID_плана"),
	FOREIGN KEY("ID_статуса") REFERENCES "СтатусРемонтаиТО"("ID_статуса")
);
CREATE TABLE IF NOT EXISTS "ТелефонСотрудника" (
	"ID_телефонасотрудника"	INTEGER,
	"Номертелефона"	INTEGER NOT NULL,
	PRIMARY KEY("ID_телефонасотрудника" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "ТелефонСпециалиста" (
	"ID_телефонаспециалиста"	INTEGER,
	"Номертелефона"	INTEGER,
	PRIMARY KEY("ID_телефонаспециалиста" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "ТипРемонта" (
	"ID_типа"	INTEGER,
	"Наименование"	TEXT NOT NULL,
	"Требуемаяквалификация"	TEXT,
	PRIMARY KEY("ID_типа" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "Уведомление" (
	"ID_уведомления"	INTEGER,
	"Датауведомления"	DATE NOT NULL,
	"ID_сотрудника"	INTEGER,
	"Содержание"	TEXT,
	"Датастатуса"	DATE,
	"ID_статуса"	INTEGER,
	PRIMARY KEY("ID_уведомления" AUTOINCREMENT),
	FOREIGN KEY("ID_сотрудника") REFERENCES "Сотрудник"("ID_сотрудника"),
	FOREIGN KEY("ID_статуса") REFERENCES "СтатусУведомления"("ID_статусауведомления")
);
INSERT INTO "АктПриемки" VALUES (1,'АК-001','2023-05-15',1,1,'ИТСО-001','Принято без замечаний',1);
INSERT INTO "АктПриемки" VALUES (2,'АК-002','2023-06-20',1,2,'ИТСО-002','Принято без замечаний',1);
INSERT INTO "АктПриемки" VALUES (3,'АК-003','2023-07-10',1,3,'ИТСО-003','Принято с замечаниями',2);
INSERT INTO "АктПриемки" VALUES (4,'АК-004','2024-01-20',2,4,'ИТСО-004','Принято без замечаний',2);
INSERT INTO "АктПриемки" VALUES (5,'АК-005','2024-01-20',2,5,'ИТСО-005','Принято без замечаний',2);
INSERT INTO "АктПриемки" VALUES (6,'АК-006','2024-02-15',2,6,'ИТСО-006','Принято без замечаний',2);
INSERT INTO "АктПриемки" VALUES (7,'АК-007','2024-02-15',2,7,'ИТСО-007','Принято без замечаний',2);
INSERT INTO "АктПриемки" VALUES (8,'АК-008','2023-10-10',3,8,'ИТСО-008','Принято',1);
INSERT INTO "АктПриемки" VALUES (9,'АК-009','2023-11-05',3,9,'ИТСО-009','Принято',1);
INSERT INTO "АктПриемки" VALUES (10,'АК-010','2023-11-05',3,10,'ИТСО-010','Принято',1);
INSERT INTO "АктПриемки" VALUES (11,'АК-011','2025-02-10',1,11,'ИТСО-011','Принято без замечаний',3);
INSERT INTO "АктПриемки" VALUES (12,'АК-012','2025-02-10',1,12,'ИТСО-012','Принято без замечаций',3);
INSERT INTO "АктПриемки" VALUES (13,'АК-013','2024-04-10',2,13,'ИТСО-013','Принято без замечаний',2);
INSERT INTO "АктПриемки" VALUES (14,'АК-014','2024-07-01',1,14,'ИТСО-014','Принято',1);
INSERT INTO "АктПриемки" VALUES (15,'АК-015','2024-08-15',2,15,'ИТСО-015','Принято без замечаний',1);
INSERT INTO "АктСписания" VALUES (1,'ОС-001','2025-01-15',3,NULL,'Физический износ (считыватель)',1,'Списать по причине износа');
INSERT INTO "АктСписания" VALUES (2,'ОС-002','2025-02-20',7,NULL,'Не подлежит восстановлению',2,'Списать');
INSERT INTO "АктСписания" VALUES (3,'ОС-003','2025-03-10',8,NULL,'Устаревшая модель',1,'Списать');
INSERT INTO "Должность" VALUES (1,'Главный инженер','Руководитель инженерной службы');
INSERT INTO "Должность" VALUES (2,'Ведущий специалист','Специалист по эксплуатации');
INSERT INTO "Должность" VALUES (3,'Начальник ОТК','Контроль качества');
INSERT INTO "Должность" VALUES (4,'Инженер','Инженерно-технический персонал');
INSERT INTO "Должность" VALUES (5,'Техник','Обслуживание оборудования');
INSERT INTO "Должность" VALUES (6,'Мастер','Руководитель работ на объекте');
INSERT INTO "Должность" VALUES (7,'Сервисный инженер','Выездное обслуживание');
INSERT INTO "Должность" VALUES (8,'Слесарь','Механические работы');
INSERT INTO "Должность" VALUES (9,'Электрик','Электромонтажные работы');
INSERT INTO "Должность" VALUES (10,'Программист','Настройка ПО');
INSERT INTO "КарточкаУчетаИТСО" VALUES (1,'СКД PERCo S-20','SN-PER-001','S-20','Проходная №1','2023-05-15',NULL,NULL,1);
INSERT INTO "КарточкаУчетаИТСО" VALUES (2,'СКД PERCo S-20','SN-PER-002','S-20','Проходная №2','2023-06-20',NULL,NULL,1);
INSERT INTO "КарточкаУчетаИТСО" VALUES (3,'СКД PERCo S-20','SN-PER-003','S-20','Проходная №3','2023-07-10',NULL,NULL,2);
INSERT INTO "КарточкаУчетаИТСО" VALUES (4,'Видеокамера HikVision','SN-HIK-045','DS-2CD2347G2','Периметр Север','2024-01-20',NULL,NULL,1);
INSERT INTO "КарточкаУчетаИТСО" VALUES (5,'Видеокамера HikVision','SN-HIK-046','DS-2CD2347G2','Периметр Юг','2024-01-20',NULL,NULL,1);
INSERT INTO "КарточкаУчетаИТСО" VALUES (6,'Видеокамера HikVision','SN-HIK-047','DS-2CD2347G2','Периметр Запад','2024-02-15',NULL,NULL,1);
INSERT INTO "КарточкаУчетаИТСО" VALUES (7,'Видеокамера HikVision','SN-HIK-048','DS-2CD2347G2','Периметр Восток','2024-02-15',NULL,NULL,2);
INSERT INTO "КарточкаУчетаИТСО" VALUES (8,'Датчик движения Optex','SN-OPT-112','LX-402','Склад №1','2023-10-10',NULL,NULL,2);
INSERT INTO "КарточкаУчетаИТСО" VALUES (9,'Датчик движения Optex','SN-OPT-113','LX-402','Склад №2','2023-11-05',NULL,NULL,1);
INSERT INTO "КарточкаУчетаИТСО" VALUES (10,'Датчик движения Optex','SN-OPT-114','LX-402','Склад №3','2023-11-05',NULL,NULL,1);
INSERT INTO "КарточкаУчетаИТСО" VALUES (11,'Контроллер PERCo','SN-PER-CTRL-01','C-20','Офис 1 этаж','2025-02-10',NULL,NULL,1);
INSERT INTO "КарточкаУчетаИТСО" VALUES (12,'Контроллер PERCo','SN-PER-CTRL-02','C-20','Офис 2 этаж','2025-02-10',NULL,NULL,1);
INSERT INTO "КарточкаУчетаИТСО" VALUES (13,'Турникет Т-3','SN-TUR-001','Т-3','Проходная','2024-04-10',NULL,NULL,1);
INSERT INTO "КарточкаУчетаИТСО" VALUES (14,'Шлагбаум СПЕЦ-Ш','SN-SH-001','СПЕЦ-Ш','Въезд на территорию','2024-07-01',NULL,NULL,1);
INSERT INTO "КарточкаУчетаИТСО" VALUES (15,'Сервер видеонаблюдения','SN-SRV-001','Dell PowerEdge','Серверная','2024-08-15',NULL,NULL,1);
INSERT INTO "ПланГрафикТО" VALUES (1,'П-001','2025 год',1,'2024-05-15','2025-05-15',365,'Ежегодное ТО');
INSERT INTO "ПланГрафикТО" VALUES (2,'П-002','2025 год',2,'2024-06-20','2025-06-20',365,'Ежегодное ТО');
INSERT INTO "ПланГрафикТО" VALUES (3,'П-003','2025 год',4,'2024-01-20','2025-01-20',365,'Ежегодное ТО');
INSERT INTO "ПланГрафикТО" VALUES (4,'П-004','2025 год',5,'2024-01-20','2025-01-20',365,'Ежегодное ТО');
INSERT INTO "ПланГрафикТО" VALUES (5,'П-005','2025 год',9,'2023-11-05','2024-11-05',365,'Ежегодное ТО');
INSERT INTO "ПланГрафикТО" VALUES (6,'П-006','2025 год',11,NULL,'2025-02-10',30,'Ежемесячное ТО');
INSERT INTO "ПланГрафикТО" VALUES (7,'П-007','2025 год',13,'2024-04-10','2025-04-10',365,'Ежегодное ТО');
INSERT INTO "ПланГрафикТО" VALUES (8,'П-008','2025 год',15,'2024-08-15','2025-08-15',365,'Ежегодное ТО');
INSERT INTO "Поставщик" VALUES (1,'ООО «ТехноСервис»','Сергеев А.А.','+7-495-123-4567','info@tehnoservis.ru');
INSERT INTO "Поставщик" VALUES (2,'АО «Безопасность+»','Кузнецов Д.Д.','+7-495-765-4321','sales@bezopasnost.ru');
INSERT INTO "Поставщик" VALUES (3,'ООО «СпецАвтоматика»','Михайлов Е.Е.','+7-495-987-6543','zakaz@spetsavtomatika.ru');
INSERT INTO "Сотрудник" VALUES (1,'Иванов Иван Иванович','ИТ-отдел','Инженер 3 кат.','Главный инженер','+7-999-111-2233');
INSERT INTO "Сотрудник" VALUES (2,'Петров Петр Петрович','Служба эксплуатации','Техник','Ведущий специалист','+7-999-222-3344');
INSERT INTO "Сотрудник" VALUES (3,'Сидорова Анна Владимировна','ОТК','Инженер по качеству','Начальник ОТК','+7-999-333-4455');
INSERT INTO "Сотрудник" VALUES (4,'Кузнецов Андрей Андреевич','Ремонтный цех','6 разряд','Сервисный инженер','+7-999-444-5566');
INSERT INTO "Сотрудник" VALUES (5,'Смирнов Дмитрий Дмитриевич','Ремонтный цех','5 разряд','Мастер','+7-999-555-6677');
INSERT INTO "СпециалистПодряднойОрганизации" VALUES (1,'Кузнецов Андрей Андреевич','+7-999-444-5566','6 разряд');
INSERT INTO "СпециалистПодряднойОрганизации" VALUES (2,'Смирнов Дмитрий Дмитриевич','+7-999-555-6677','Электромонтёр');
INSERT INTO "СпециалистПодряднойОрганизации" VALUES (3,'Васильева Елена Александровна','+7-999-666-7788','Инженер 2 кат.');
INSERT INTO "СтатусОборудования" VALUES (1,'В эксплуатации');
INSERT INTO "СтатусОборудования" VALUES (2,'На ремонте');
INSERT INTO "СтатусОборудования" VALUES (3,'Списано');
INSERT INTO "СтатусОборудования" VALUES (4,'Резерв');
INSERT INTO "СтатусРемонтаиТО" VALUES (1,'Запланирован');
INSERT INTO "СтатусРемонтаиТО" VALUES (2,'В процессе');
INSERT INTO "СтатусРемонтаиТО" VALUES (3,'Завершён');
INSERT INTO "СтатусРемонтаиТО" VALUES (4,'Отложен');
INSERT INTO "СтатусРемонтаиТО" VALUES (5,'Отменён');
INSERT INTO "ТипРемонта" VALUES (1,'Внешний','Техник 3 разряда');
INSERT INTO "ТипРемонта" VALUES (2,'Внутренний','Инженер');
INSERT INTO "ТипРемонта" VALUES (3,'Внешний','Инженер 2 категории');
INSERT INTO "ТипРемонта" VALUES (4,'Внешний','Бригада специалистов');
COMMIT;
