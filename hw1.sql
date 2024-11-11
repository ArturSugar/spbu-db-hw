-- Создание таблицы courses для хранения информации о курсах студентов
CREATE TABLE courses (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,       -- Название курса
    is_exam BOOLEAN NOT NULL,         -- Признак экзаменационного курса
    min_grade INT CHECK (min_grade >= 0), -- Минимальная оценка
    max_grade INT CHECK (max_grade <= 100) -- Максимальная оценка
);

-- Создание таблицы groups
CREATE TABLE groups (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    short_name VARCHAR(20) NOT NULL,
    students_ids INT[]
);

-- Создание таблицы students для хранения информации о студентах
CREATE TABLE students (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,     -- Имя студента
    last_name VARCHAR(50) NOT NULL,      -- Фамилия студента
    group_id INT REFERENCES groups(id),  -- ID группы
    courses_ids INT[]                    -- Список ID курсов
);


-- Курсы, на которые записаны студенты
INSERT INTO courses (name, is_exam, min_grade, max_grade) VALUES
('СУБД', TRUE, 0, 100),
('Алгоритмы обработки изображений', FALSE, 0, 100),
('Компьютерное зрение', FALSE, 0, 100),
('Теория Байесовских сетей.', TRUE, 0, 100),
('Анализ соцсетей', TRUE, 0, 100);

--
INSERT INTO groups (full_name, short_name, students_ids) VALUES
('группа 81', '81', ARRAY[]::integer[]),
('группа 82', '82', ARRAY[]::integer[]);

-- Вставка данных в таблицу students с распределением по курсам
INSERT INTO students (first_name, last_name, group_id, courses_ids) VALUES
-- Первая группа
('Павел', 'Алимов', 1, ARRAY[1, 4, 5]),
('Давид', 'Асатуров', 1, ARRAY[1, 2, 4, 5]),
('Эшгин', 'Байрамов', 1, ARRAY[1, 3, 4, 5]),
('Данил', 'Белоусов', 1, ARRAY[1, 4, 5]),
('Всеволод', 'Битепаж', 1, ARRAY[1, 3, 4, 5]),
('Артем', 'Буренок', 1, ARRAY[1, 2, 4, 5]),
('Диана', 'Винницкая', 1, ARRAY[1, 4, 5]),
('Элина', 'Владимирова', 1, ARRAY[1, 2, 4, 5]),
('Егор', 'Вундер', 1, ARRAY[1,2, 3, 4, 5]),
('Николай', 'Григорьев', 1, ARRAY[1, 4, 5]),
('Ян', 'Егоров', 1, ARRAY[1,3, 4, 5]),
('Артем', 'Ермаков', 1, ARRAY[1, 2, 4, 5]),
('Даниил', 'Ерофеевский', 1, ARRAY[1, 4, 5]),
('Максим', 'Есин', 1, ARRAY[1,2, 3, 4, 5]),
('Данила', 'Заварзин', 1, ARRAY[1, 4, 5]),
('Борис', 'Закатов', 1, ARRAY[1, 4, 5]),
('Абакар', 'Махамат', 2, ARRAY[1, 4, 5]),
('Фис Де Дье', 'Алуна Нку', 2, ARRAY[1, 4, 5]),
('Абубакари', 'Ба', 2, ARRAY[1, 2, 4, 5]),
('Владислав', 'Байханов', 2, ARRAY[1, 4, 5]),

-- Вторая группа
('Елизавета', 'Лексина', 2, ARRAY[1, 4, 5]),
('Михаил', 'Минаев', 2, ARRAY[1, 3, 4, 5]),
('Анна', 'Овчинникова', 2, ARRAY[1, 3, 4, 5]),
('Роман', 'Павлов', 2, ARRAY[1, 2, 4, 5]),
('Анна', 'Платонова', 2, ARRAY[1, 4, 5]),
('Георгий', 'Пономарев', 2, ARRAY[1, 4, 5]),
('Данил', 'Прибытков', 2, ARRAY[1, 3, 4, 5]),
('Артём', 'Пышный', 2, ARRAY[1, 4, 5]),
('Александра', 'Решетникова', 2, ARRAY[1, 2, 4, 5]),
('Вадим', 'Сазанов', 2, ARRAY[1, 4, 5]),
('Артур', 'Сахаров', 2, ARRAY[1, 4, 5]),
('Глеб', 'Семакин', 2, ARRAY[1, 4, 5]),
('Софья', 'Теплинских', 2, ARRAY[1, 3, 4, 5]),
('Максим', 'Трапер', 2, ARRAY[1, 4, 5]),
('Максим', 'Трифонов', 2, ARRAY[1, 4, 5]),
('Артём', 'Федосеев', 2, ARRAY[1, 4, 5]),
('Анна', 'Цветкова', 2, ARRAY[1, 4, 5]),
('Вероника', 'Циунчик', 2, ARRAY[1, 2, 4, 5]),
('Артём', 'Чекалев', 2, ARRAY[1, 3, 4, 5]),
('Бандиугу', 'Сиссоко', 2, ARRAY[1, 2, 4, 5]),
('Цзучэн', 'Лю', 2, ARRAY[1, 4, 5]),
('Лэ', 'Чан', 2, ARRAY[1, 3, 4, 5]);

-- Таблица для курса "СУБД"
CREATE TABLE subd_course (
    student_id INT REFERENCES students(id),   -- ID студента
    grade INT CHECK (grade BETWEEN 0 AND 100), -- Оценка (от 0 до 100)
    grade_str VARCHAR(10) GENERATED ALWAYS AS (
        CASE
            WHEN grade >= 90 THEN 'A'
            WHEN grade >= 80 THEN 'B'
            WHEN grade >= 70 THEN 'C'
            WHEN grade >= 60 THEN 'D'
            when grade >= 50 THEN 'E'
            ELSE 'F'
        END
    ) STORED
);
-- Таблица для курса "Алгоритмы обработки изображений"
CREATE TABLE image_processing_course (
    student_id INT REFERENCES students(id),   -- ID студента
    grade INT CHECK (grade BETWEEN 0 AND 100), -- Оценка (от 0 до 100)
    grade_str VARCHAR(10) GENERATED ALWAYS AS (
        CASE
            WHEN grade >= 90 THEN 'A'
            WHEN grade >= 80 THEN 'B'
            WHEN grade >= 70 THEN 'C'
            WHEN grade >= 60 THEN 'D'
            when grade >= 50 THEN 'E'
            ELSE 'F'
        END
    ) STORED
);
-- Таблица для курса "Компьютерное зрение"
CREATE TABLE computer_vision_course (
    student_id INT REFERENCES students(id),   -- ID студента
    grade INT CHECK (grade BETWEEN 0 AND 100), -- Оценка (от 0 до 100)
    grade_str VARCHAR(10) GENERATED ALWAYS AS (
        CASE
            WHEN grade >= 90 THEN 'A'
            WHEN grade >= 80 THEN 'B'
            WHEN grade >= 70 THEN 'C'
            WHEN grade >= 60 THEN 'D'
            when grade >= 50 THEN 'E'
            ELSE 'F'
        END
    ) STORED
);
-- Таблица для курса "Теория Байесовских сетей"
CREATE TABLE bayesian_networks_course (
    student_id INT REFERENCES students(id),   -- ID студента
    grade INT CHECK (grade BETWEEN 0 AND 100), -- Оценка (от 0 до 100)
    grade_str VARCHAR(10) GENERATED ALWAYS AS (
        CASE
            WHEN grade >= 90 THEN 'A'
            WHEN grade >= 80 THEN 'B'
            WHEN grade >= 70 THEN 'C'
            WHEN grade >= 60 THEN 'D'
            when grade >= 50 THEN 'E'
            ELSE 'F'
        END
    ) STORED
);
-- Таблица для курса "Анализ соцсетей"
CREATE TABLE social_network_analysis_course (
    student_id INT REFERENCES students(id),   -- ID студента
    grade INT CHECK (grade BETWEEN 0 AND 100), -- Оценка (от 0 до 100)
    grade_str VARCHAR(10) GENERATED ALWAYS AS (
        CASE
            WHEN grade >= 90 THEN 'A'
            WHEN grade >= 80 THEN 'B'
            WHEN grade >= 70 THEN 'C'
            WHEN grade >= 60 THEN 'D'
            when grade >= 50 THEN 'E'
            ELSE 'F'
        END
    ) STORED
);

INSERT INTO subd_course (student_id, grade) VALUES
(1, 85), (2, 78), (3, 92), (4, 88), (5, 67),
(6, 90), (7, 76), (8, 59), (9, 83), (10, 95),
(11, 70), (12, 66), (13, 80), (14, 72), (15, 60),
(16, 77), (17, 88), (18, 54), (19, 63), (20, 85),
(21, 92), (22, 81), (23, 69), (24, 74), (25, 79),
(26, 55), (27, 68), (28, 73), (29, 82), (30, 87),
(31, 60), (32, 50), (33, 58), (34, 96), (35, 64),
(36, 85), (37, 77), (38, 93), (39, 88), (40, 72),
(41, 49), (42, 50);


-- Получение списка студентов, записанных на курс по Компьютерному зрению
SELECT students.first_name, students.last_name
FROM students
JOIN courses c ON c.id = ANY(students.courses_ids)
WHERE c.name = 'Компьютерное зрение';

-- Получение списка студентов в группе 1
SELECT first_name, last_name
FROM students
WHERE group_id = 1;

-- Получение списка студентов с оценкой отлично (А) по курсу СУБД
SELECT students.first_name, students.last_name, subd_course.grade
FROM students
JOIN subd_course ON students.id = subd_course.student_id
WHERE subd_course.grade_str = 'A';

-- Средний бал за курс по СУБД
SELECT AVG(subd_course.grade)
FROM subd_course