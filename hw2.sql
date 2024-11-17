INSERT INTO image_processing_course (student_id, grade) VALUES
(2, 85), (6, 79), (8, 88),(9, 68), (12, 74),
(14, 81),(19, 87), (24, 70), (29, 75), (38, 62),
(40, 80);

INSERT INTO computer_vision_course (student_id, grade) VALUES
(3, 88), (5, 72), (9, 90), (11, 76), (14, 80),
(22, 83), (23, 78), (27, 85), (33, 69), (39, 91),
(42, 73);

INSERT INTO bayesian_networks_course (student_id, grade) VALUES
(1, 92), (2, 89),(3, 51), (4, 78), (5, 81), (6, 91),
(7, 84), (8, 88), (9, 73), (10, 69), (11, 76),
(12, 79), (13, 68), (14, 85), (15, 90), (16, 72),
(17, 95), (18, 88), (19, 82), (20, 83), (21, 77),
(22, 91), (23, 86), (24, 75), (25, 70), (26, 73),
(27, 82), (28, 69), (29, 84), (30, 78), (31, 100),
(32, 80), (33, 87), (34, 49), (35, 75), (36, 69),
(37, 72), (38, 81), (39, 78), (40, 85), (41, 74),
(42, 79);

INSERT INTO social_network_analysis_course (student_id, grade) VALUES
(1, 86), (2, 91), (3, 77), (4, 88), (5, 89),
(6, 74), (7, 92), (8, 73), (9, 89), (10, 82),
(11, 76), (12, 85), (13, 83), (14, 78), (15, 87),
(16, 92), (17, 74), (18, 85), (19, 79), (20, 80),
(21, 89), (22, 91), (23, 76), (24, 88), (25, 77),
(26, 85), (27, 90), (28, 78), (29, 83), (30, 87),
(31, 100), (32, 73), (33, 80), (34, 69), (35, 85),
(36, 0), (37, 86), (38, 74), (39, 93), (40, 82),
(41, 89), (42, 78);


-- **1**

--  Создание таблицы student_courses
CREATE TABLE student_courses (
id SERIAL PRIMARY KEY,
student_id INT REFERENCES students(id),
course_id INT REFERENCES courses(id),
UNIQUE (student_id, course_id));
--  Создание таблицы group_courses
CREATE TABLE group_courses (
id SERIAL PRIMARY KEY,
group_id INT REFERENCES groups(id),
course_id INT REFERENCES courses(id),
UNIQUE (group_id, course_id));

-- Заполнение таблицы student_courses
INSERT INTO student_courses (student_id, course_id)
SELECT  students.id AS student_id,
unnest(students.courses_ids) AS course_id
FROM students ;

-- Заполнение таблицы group_courses
INSERT INTO group_courses (group_id, course_id)
SELECT DISTINCT students.group_id,
student_courses.course_id
FROM
student_courses
JOIN
students ON student_courses.student_id = students.id;

-- Удаление не нужных полей
ALTER TABLE students
DROP COLUMN courses_ids;
ALTER TABLE groups
DROP COLUMN students_ids;



     
-- **2**
-- Уникальное имя для курсов
ALTER TABLE courses
ADD CONSTRAINT unique_course_name UNIQUE (name);
-- Индекс для поля group_id (идея индекса заключается в следующем: вместо загрузки всех полей таблицы, будет осуществлен переход сразу к индексу, что увеличвает скорость)
CREATE INDEX idx_students_group_id ON students (group_id);

-- **3**


-- Студенты с их курсами
SELECT
students.first_name,
students.last_name,
STRING_AGG(courses.name, ', ') AS courses
FROM
students
JOIN
student_courses sc ON students.id = sc.student_id
JOIN
courses  ON sc.course_id = courses.id
GROUP BY
students.id, students.first_name, students.last_name
ORDER BY
students.last_name, students.first_name
LIMIT 30;


-- Вспомогательный запрос, где считаем средний балл
WITH student_avg_grades AS (
SELECT s.id AS student_id, s.first_name, s.last_name,s.group_id, AVG(grade) AS avg_grade
FROM students s
JOIN (
    SELECT   student_id, grade
    FROM  subd_course
    UNION ALL
    SELECT   student_id,  grade
    FROM image_processing_course
    UNION ALL
    SELECT student_id,grade
    FROM computer_vision_course
    UNION ALL
    SELECT student_id,grade
    FROM bayesian_networks_course
    UNION ALL
    SELECT student_id,grade
    FROM social_network_analysis_course)
AS all_grades ON s.id = all_grades.student_id
GROUP BY s.id, s.first_name, s.last_name, s.group_id)
-- Запрос для групировки при помощи HAVING
SELECT first_name, last_name, group_id, avg_grade
FROM student_avg_grades
GROUP BY group_id, first_name, last_name, avg_grade
HAVING
avg_grade = (
    SELECT MAX(avg_grade)
    FROM student_avg_grades AS sag2
    WHERE sag2.group_id = student_avg_grades.group_id)

ORDER BY
group_id;

-- **4**
-- кол-во студентов на каждом курсе
SELECT  c.name AS course_name, COUNT(sc.student_id) AS student_count
FROM courses c
JOIN student_courses sc ON c.id = sc.course_id
GROUP BY c.name
ORDER BY student_count;

-- Средняя оценка по каждому курсу.
SELECT 'СУБД' AS course_name, AVG(grade) AS average_grade FROM subd_course
UNION ALL
SELECT 'Алгоритмы обработки изображений' AS course_name, AVG(grade) FROM image_processing_course
UNION ALL
SELECT 'Компьютерное зрение' AS course_name, AVG(grade) FROM computer_vision_course
UNION ALL
SELECT 'Теория Байесовских сетей' AS course_name, AVG(grade) FROM bayesian_networks_course
UNION ALL
SELECT 'Анализ соцсетей' AS course_name, AVG(grade) FROM social_network_analysis_course;

