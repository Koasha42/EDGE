CREATE TABLE `students`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `name` TEXT NOT NULL,
    `date of birth` DATETIME NOT NULL,
    `dept_id` BIGINT NOT NULL
);
CREATE TABLE `departments`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `name` TEXT NOT NULL
);
CREATE TABLE `courses`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `name` TEXT NOT NULL,
    `dept_id` BIGINT NOT NULL
);
CREATE TABLE `enrollments`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `student_id` BIGINT NOT NULL,
    `course_id` BIGINT NOT NULL,
    `grade` FLOAT(53) NOT NULL
);
ALTER TABLE
    `courses` ADD CONSTRAINT `courses_dept_id_foreign` FOREIGN KEY(`dept_id`) REFERENCES `departments`(`id`);
ALTER TABLE
    `students` ADD CONSTRAINT `students_dept_id_foreign` FOREIGN KEY(`dept_id`) REFERENCES `departments`(`id`);
ALTER TABLE
    `enrollments` ADD CONSTRAINT `enrollments_course_id_foreign` FOREIGN KEY(`course_id`) REFERENCES `courses`(`id`);
ALTER TABLE
    `enrollments` ADD CONSTRAINT `enrollments_student_id_foreign` FOREIGN KEY(`student_id`) REFERENCES `students`(`id`);