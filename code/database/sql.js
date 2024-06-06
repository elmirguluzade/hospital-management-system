const mysql = require('mysql2')

const pool = mysql.createPool({
    host: 'localhost',
    port: 3306,
    user: 'root',
    password: 'E20dp055elmir.',
    database: 'hospital'
})

const promisePool = pool.promise();

// select query
export const selectSql = {
    getDoctorName: async () => {
        const sql = `select name, doctor_id from doctor`;
        const [result] = await promisePool.query(sql);
        return result;
    },
    getPatientName: async () => {
        const sql = `select name, patient_id from patient`;
        const [result] = await promisePool.query(sql);
        return result;
    },
    getPatient: async () => {
        const sql = `select * from patient`;
        const [result] = await promisePool.query(sql);
        return result;
    },
    getExamination: async (id) => {
        const sql = `select * from examination where doctor_id=${id}`;
        const [result] = await promisePool.query(sql);
        return result;
    },
    getTreatment: async (id) => {
        const sql = `select * from treatment where nurse_id=${id}`;
        const [result] = await promisePool.query(sql);
        return result;
    },
    getReservation: async (id) => {
        const sql = `select * from reservation join medical_speciality as ms on ms.department_id=reservation.department_id where patient_id=${id}`;
        const [result] = await promisePool.query(sql);
        return result;
    },
    getDoctor: async () => {
        const sql = `select *, doctor.phone_number AS doctor_phone, ms.* from doctor join medical_speciality as ms on doctor.department_id = ms.department_id;`;
        const [result] = await promisePool.query(sql);
        return result;
    },
    getNurse: async () => {
        const sql = `select *, nurse.phone_number as nurse_phone from nurse join medical_speciality as ms on nurse.department_id = ms.department_id;`;
        const [result] = await promisePool.query(sql);
        return result;
    },
    getOneDeartment: async (id) => {
        const sql = `select * from medical_speciality where department_id=${id}`;
        const [result] = await promisePool.query(sql);
        return result;
    },
    getDeartmentName: async () => {
        const sql = `select department_name, department_id from medical_speciality`;
        const [result] = await promisePool.query(sql);
        return result;
    },
    getNurseName: async () => {
        const sql = `select name, nurse_id from nurse`;
        const [result] = await promisePool.query(sql);
        return result;
    },
    getPatientDetails: async (name) => {
        const sql = `select * from patient where name="${name}"`;
        const [result] = await promisePool.query(sql);
        return result;
    },
}

// update query
export const updateSql = {
    updateDoctor: async (data) => {
        const sql = `
        UPDATE doctor 
        SET name = "${data.name}", 
            address = "${data.address}", phone_number = "${data.phone_number}",
            password = "${data.password}", department_id="${data.department_id}" WHERE doctor_id = ${data.id}`;
        await promisePool.query(sql);
    },
    updateNurse: async (data) => {
        const sql = `
        UPDATE nurse 
        SET name = "${data.name}", 
            address = "${data.address}", phone_number = "${data.phone_number}",
            password = "${data.password}", department_id="${data.department_id}" WHERE nurse_id = ${data.id}`;
        await promisePool.query(sql);
    },
    updateExamination: async (data) => {
        const sql = `
        UPDATE examination
        SET examination_details = "${data.details}", 
        examination_date = "${data.date}" where doctor_id = ${data.doctor} and examination_date="${data.oldDate}"`;
        await promisePool.query(sql);
    },
    updateTreatment: async (data) => {
        const sql = `
        UPDATE treatment
        SET treatment_details = "${data.details}", 
        treatment_date = "${data.date}" where nurse_id = ${data.nurse} and treatment_date="${data.oldDate}"`;
        await promisePool.query(sql);
    },
};

// delete query
export const deleteSql = {
    deleteDoctor: async (id) => {
        const connection = await promisePool.getConnection();
        try {
            await connection.query('START TRANSACTION');
            await connection.query('DELETE FROM patient_has_doctor WHERE doctor_id = ?', [id]);
            await connection.query('DELETE FROM examination WHERE doctor_id = ?', [id]);
            await connection.query('DELETE FROM doctor WHERE doctor_id = ?', [id]);
            await connection.query('COMMIT');
        } catch (err) {
            await connection.query('ROLLBACK');
        } finally {
            connection.release();
        }
    },
    deleteNurse: async (id) => {
        const connection = await promisePool.getConnection();
        try {
            await connection.query('START TRANSACTION');
            await connection.query('delete from nurse_has_patient where nurse_id = ?', [id]);
            await connection.query('delete from treatment where nurse_id = ?', [id]);
            await connection.query('delete from nurse where nurse_id = ?', [id]);
            await connection.query('COMMIT');
        } catch (err) {
            await connection.query('ROLLBACK');
        } finally {
            connection.release();
        }
    },
    deleteExamination: async (id) => {
        await promisePool.query(`delete from examination where examination_date="${id}"`);
    },
    deleteTreatment: async (date) => {
        await promisePool.query(`delete from treatment where treatment_date="${date}"`);
    },
    deleteReservation: async (id) => {
        await promisePool.query(`delete from reservation where reserv_num="${id}"`);
    }
}

// insert query
export const insertSql = {
    setDoctor: async (data) => {
        const sql = `insert into doctor (name, address, phone_number, password, department_id) values (
            "${data.name}", "${data.address}", 
            "${data.phone_number}", "${data.password}", "${data.department}"
        )`
        await promisePool.query(sql);
    },
    setNurse: async (data) => {
        const sql = `insert into nurse (name, address, phone_number, password, department_id) values (
            "${data.name}", "${data.address}", 
            "${data.phone_number}", "${data.password}", "${data.department}"
        )`
        await promisePool.query(sql);
    },
    setExamination: async (data) => {
        const sql = `insert into examination values (
            "${data.examDetails}", "${data.examDate}", "${data.doctorId}", 
            "${data.patientId}"
        )`
        await promisePool.query(sql);
    },
    setTreatment: async (data) => {
        const sql = `insert into treatment values (
            "${data.treatmentDetails}", "${data.treatmentDate}", "${data.nurseId}", 
            "${data.patientId}"
        )`
        await promisePool.query(sql);
    },
    setReservation: async (data) => {
        const sql = `insert into reservation (reserv_date, department_id, patient_id) values (
            "${data.reservDate}", "${data.departmentId}", "${data.patientId}"
        )`
        await promisePool.query(sql);
    },
};

