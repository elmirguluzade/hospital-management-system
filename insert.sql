-- Inserting data into `patient` table
INSERT INTO `hospital`.`patient` (`patient_id`, `name`, `social_security_number`, `gender`, `address`, `blood_type`, `height`, `weight`, `phone_number`, `password`)
VALUES
(123001, 'John Doe', '123-45-6789', 'Male', '123 Broadway', 'O+', '175cm', '70kg', '999-888-7777', 'patient1'),
(123002, 'Jane Smith', '987-65-4321', 'Female', '456 Pine St', 'A-', '160cm', '55kg', '888-777-6666', 'patient2'),
(123003, 'David Johnson', '567-89-0123', 'Male', '789 Oak St', 'B+', '180cm', '80kg', '777-666-5555', 'patient3'),
(123004, 'Sarah Brown', '543-21-0987', 'Female', '987 Elm St', 'AB-', '165cm', '60kg', '666-555-4444', 'patient4'),
(123005, 'Emily Davis', '234-56-7890', 'Female', '654 Maple St', 'O-', '170cm', '65kg', '555-444-3333', 'patient5');


-- Inserting data into `medical_speciality` table
INSERT INTO `hospital`.`medical_speciality` (`department_id`, `department_name`, `phone_number`)
VALUES
(1, 'Cardiology', '123-456-7890'),
(2, 'Neurology', '234-567-8901'),
(3, 'Orthopedics', '345-678-9012'),
(4, 'Pediatrics', '456-789-0123'),
(5, 'Oncology', '567-890-1234');

-- Inserting data into `doctor` table
INSERT INTO `hospital`.`doctor` (`doctor_id`, `name`, `address`, `phone_number`, `password`, `department_id`)
VALUES
(124001, 'Dr. Smith', '123 Main St', '111-222-3333', 'doctor1', 1),
(124002, 'Dr. Johnson', '456 Elm St', '222-333-4444', 'doctor2', 2),
(124003, 'Dr. Williams', '789 Oak St', '333-444-5555', 'doctor3', 3),
(124004, 'Dr. Brown', '987 Pine St', '444-555-6666', 'doctor4', 4),
(124005, 'Dr. Davis', '654 Maple St', '555-666-7777', 'doctor5', 5);

-- Inserting data into `nurse` table
INSERT INTO `hospital`.`nurse` (`nurse_id`, `name`, `address`, `phone_number`, `password`, `department_id`)
VALUES
(125001, 'Nurse Adams', '111 Hill St', '777-888-9999', 'nurse1', 1),
(125002, 'Nurse Baker', '222 Ridge St', '888-999-0000', 'nurse2', 2),
(125003, 'Nurse Clark', '333 Valley St', '999-000-1111', 'nurse3', 3),
(125004, 'Nurse Evans', '444 Lake St', '000-111-2222', 'nurse4', 4),
(125005, 'Nurse Foster', '555 Park St', '111-222-3333', 'nurse5', 5);

-- Inserting data into `inpatient` table
INSERT INTO `hospital`.`inpatient` (`room`, `admission_date`, `discharge_date`, `patient_id`)
VALUES
('101', '2023-01-01 05:43:12', '2023-01-10 05:43:12', 123001),
('202', '2023-02-01 11:23:10', '2023-02-15 02:43:12', 123002),
('303', '2023-03-01 00:41:54', '2023-03-20 01:43:12', 123003),
('404', '2023-04-01 15:23:25', '2023-04-25 02:43:12', 123004),
('505', '2023-05-01 15:43:54', '2023-05-30 03:43:12', 123005);

-- Inserting data into `reservation` table
INSERT INTO `hospital`.`reservation` (`reserv_num`, `reserv_date`, `department_id`, `patient_id`)
VALUES
(1, '2023-01-05 15:43:12', 1, 123001),
(2, '2023-02-10 05:43:22', 2, 123002),
(3, '2023-03-15 05:34:12', 3, 123003),
(4, '2023-04-20 05:13:12', 4, 123004),
(5, '2023-05-25 05:43:42', 5, 123005);

-- Inserting data into `examination` table
INSERT INTO `hospital`.`examination` (`examination_date`, `examination_details`, `doctor_id`, `patient_id`)
VALUES
('2023-01-06 23:43:12', 'Routine checkup', 124001, 123001),
('2023-02-12 11:43:12', 'Neurological exam', 124002, 123002),
('2023-03-18 01:43:12', 'Orthopedic consultation', 124003, 123003),
('2023-04-22 15:43:12', 'Pediatric assessment', 124004, 123004),
('2023-05-28 05:13:12', 'Oncology screening', 124005, 123005);

-- Inserting data into `treatment` table
INSERT INTO `hospital`.`treatment` (`treatment_date`, `treatment_details`, `nurse_id`, `patient_id`)
VALUES
('2023-01-07 13:43:12', 'Medication administration', 125001, 123001),
('2023-02-13 23:43:12', 'Physical therapy', 125002, 123002),
('2023-03-19 01:43:12', 'Wound care', 125003, 123003),
('2023-04-23 23:42:12', 'Vaccination', 125004, 123004),
('2023-05-29 23:13:12', 'Chemotherapy', 125005, 123005);

-- Inserting data into `nurse_has_patient` table
INSERT INTO `hospital`.`nurse_has_patient` (`nurse_id`, `patient_id`)
VALUES
(125001, 123001),
(125002, 123002),
(125003, 123003),
(125004, 123004),
(125005, 123005);

-- Inserting data into `patient_has_doctor` table
INSERT INTO `hospital`.`patient_has_doctor` (`patient_id`, `doctor_id`)
VALUES
(123001, 124001),
(123002, 124002),
(123003, 124003),
(123004, 124004),
(123005, 124005);
