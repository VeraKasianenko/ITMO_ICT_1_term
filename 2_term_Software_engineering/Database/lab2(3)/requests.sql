SELECT "Н_ЛЮДИ"."ИМЯ","Н_ЛЮДИ"."ФАМИЛИЯ", "Н_ВЕДОМОСТИ"."ИД"
FROM "Н_ЛЮДИ"
RIGHT JOIN "Н_ВЕДОМОСТИ" ON "Н_ЛЮДИ"."ИД" = "Н_ВЕДОМОСТИ"."ЧЛВК_ИД"
WHERE "Н_ЛЮДИ"."ФАМИЛИЯ" < 'Иванов'
AND "Н_ВЕДОМОСТИ"."ИД" IN (1250981, 1250972);

SELECT "Н_ЛЮДИ"."ОТЧЕСТВО", "Н_ВЕДОМОСТИ"."ДАТА", "Н_СЕССИЯ"."ИД"
FROM "Н_ЛЮДИ"
RIGHT JOIN "Н_ВЕДОМОСТИ" ON "Н_ЛЮДИ"."ИД" = "Н_ВЕДОМОСТИ"."ЧЛВК_ИД"
RIGHT JOIN "Н_СЕССИЯ" ON "Н_ВЕДОМОСТИ"."СЭС_ИД" = "Н_СЕССИЯ"."СЭС_ИД"
WHERE "Н_ЛЮДИ"."ИД" < 100012
AND "Н_ВЕДОМОСТИ"."ИД" = 1457443

SELECT COUNT("Н_УЧЕНИКИ"."ИД")
FROM "Н_УЧЕНИКИ"
JOIN "Н_ПЛАНЫ" ON "Н_УЧЕНИКИ"."ПЛАН_ИД" = "Н_ПЛАНЫ"."ИД"
JOIN "Н_ОТДЕЛЫ" ON "Н_ПЛАНЫ"."ОТД_ИД" = "Н_ОТДЕЛЫ"."ИД"
JOIN "Н_ЛЮДИ" ON "Н_УЧЕНИКИ"."ЧЛВК_ИД" = "Н_ЛЮДИ"."ИД"
AND EXTRACT(YEAR FROM age("Н_ЛЮДИ"."ДАТА_РОЖДЕНИЯ")) > 25
AND "Н_ОТДЕЛЫ"."КОРОТКОЕ_ИМЯ" = 'КТиУ'

SELECT "Н_ГРУППЫ_ПЛАНОВ"."ПЛАН_ИД", count("Н_ГРУППЫ_ПЛАНОВ"."ГРУППА")
FROM "Н_ГРУППЫ_ПЛАНОВ" JOIN "Н_ПЛАНЫ" ON "Н_ПЛАНЫ"."ИД" = "Н_ГРУППЫ_ПЛАНОВ"."ПЛАН_ИД" JOIN "Н_ФОРМЫ_ОБУЧЕНИЯ" ON "Н_ПЛАНЫ"."ФО_ИД" = "Н_ФОРМЫ_ОБУЧЕНИЯ"."ИД"
WHERE "Н_ФОРМЫ_ОБУЧЕНИЯ"."НАИМЕНОВАНИЕ" = 'Заочная'
GROUP BY "Н_ГРУППЫ_ПЛАНОВ"."ПЛАН_ИД"
HAVING count("Н_ГРУППЫ_ПЛАНОВ"."ГРУППА") > 2;

SELECT "Н_ЛЮДИ"."ИД", "ФАМИЛИЯ", "ИМЯ", "ОТЧЕСТВО", AVG(CAST("ОЦЕНКА" AS NUMERIC)) AS "СРЕДНЯЯ_ОЦЕНКА"
FROM "Н_ЛЮДИ"
JOIN "Н_УЧЕНИКИ" ON "Н_УЧЕНИКИ"."ЧЛВК_ИД" = "Н_ЛЮДИ"."ИД" AND "Н_УЧЕНИКИ"."ГРУППА" = '4100'
JOIN "Н_ВЕДОМОСТИ"
ON "Н_ВЕДОМОСТИ"."ЧЛВК_ИД" = "Н_ЛЮДИ"."ИД" AND "ОЦЕНКА" NOT IN ('осв', 'неявка', 'зачет', 'незач')
GROUP BY "Н_ЛЮДИ"."ИД", "ФАМИЛИЯ", "ИМЯ", "ОТЧЕСТВО"
HAVING AVG(CAST ("ОЦЕНКА" AS NUMERIC)) < (SELECT MIN (EXP.MARK)
FROM (
SELECT AVG(CAST ("ОЦЕНКА" AS NUMERIC)) AS MARK
FROM "Н_УЧЕНИКИ"
JOIN "Н_ВЕДОМОСТИ" ON "Н_УЧЕНИКИ"."ГРУППА" = '3100'
AND "Н_УЧЕНИКИ"."ЧЛВК_ИД" = "Н_ВЕДОМОСТИ"."ЧЛВК_ИД"
AND "ОЦЕНКА" NOT IN('осв', 'неявка', 'зачет', 'незач')
) EXP);

SELECT "Н_УЧЕНИКИ"."ГРУППА", "Н_УЧЕНИКИ"."ИД", "Н_ЛЮДИ"."ФАМИЛИЯ", "Н_ЛЮДИ"."ИМЯ", "Н_ЛЮДИ"."ОТЧЕСТВО", "Н_УЧЕНИКИ"."П_ПРКОК_ИД"
FROM "Н_УЧЕНИКИ"
JOIN "Н_ЛЮДИ" ON "Н_УЧЕНИКИ"."ЧЛВК_ИД" = "Н_ЛЮДИ"."ИД"
JOIN "Н_ПЛАНЫ" ON "Н_УЧЕНИКИ"."ПЛАН_ИД" = "Н_ПЛАНЫ"."ИД"
JOIN "Н_НАПРАВЛЕНИЯ_СПЕЦИАЛ" ON "Н_ПЛАНЫ"."НАПС_ИД" = "Н_НАПРАВЛЕНИЯ_СПЕЦИАЛ"."ИД"
JOIN "Н_НАПР_СПЕЦ" ON "Н_НАПРАВЛЕНИЯ_СПЕЦИАЛ"."НС_ИД" = "Н_НАПР_СПЕЦ"."ИД"
WHERE "Н_УЧЕНИКИ"."КОНЕЦ" < '2012-09-01'
AND "Н_УЧЕНИКИ"."ПРИЗНАК" = 'отчисл'
AND "Н_НАПР_СПЕЦ"."КОД_НАПРСПЕЦ" = '230101';

SELECT "Н_ЛЮДИ"."ФАМИЛИЯ", "Н_ЛЮДИ"."ИМЯ", "Н_ЛЮДИ"."ОТЧЕСТВО"
FROM "Н_ЛЮДИ"
LEFT JOIN "Н_УЧЕНИКИ" ON "Н_ЛЮДИ"."ИД" = "Н_УЧЕНИКИ"."ЧЛВК_ИД"
WHERE "Н_УЧЕНИКИ"."ЧЛВК_ИД" IS NULL;