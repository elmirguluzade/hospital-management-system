const { selectSql, updateSql, deleteSql, insertSql } = require("../database/sql");

exports.renderPage = async (req, res) => {
    if (!req.cookies.user) {
        res.redirect('/')
    }

    //admin
    if (req.cookies.user[1] == "admin") {
        const Doctor = await selectSql.getDoctor();
        const Nurse = await selectSql.getNurse();
        res.render('admin', {
            layout: 'layout',
            title1: "Doctor",
            title2: "Nurse",
            Doctor,
            Nurse
        })
    }

    //doctor
    if (req.cookies.user[1] == "doctor") {
        const Examination = await selectSql.getExamination(req.cookies.user[0]);
        res.render('examination', {
            title1: "Examination",
            Examination,
        })
    }

    //nurse
    if (req.cookies.user[1] == "nurse") {
        const Treatment = await selectSql.getTreatment(req.cookies.user[0]);
        res.render('treatment', {
            title1: "Treatment",
            Treatment,
        })
    }

    //patient
    if (req.cookies.user[1] == "patient") {
        const Reservation = await selectSql.getReservation(req.cookies.user[0]);
        res.render('reservation', {
            title1: "Reservation",
            Reservation,
        })
    }
};

exports.modify = async (req, res) => {
    const vars = req.body;

    //admin
    if (req.cookies.user[1] == "admin") {
        const role = req.params.role;
        const data = {
            id: vars.id,
            name: vars.name,
            address: vars.address,
            phone_number: vars.phone_number,
            password: vars.password,
            department_id: vars.department_id
        }
        const checkDepartmentId = await selectSql.getOneDeartment(vars.department_id);
        if (checkDepartmentId.length != 0) {
            if (role == "doctor") await updateSql.updateDoctor(data);
            else if (role == "nurse") await updateSql.updateNurse(data);
            res.redirect('/enter/edit');
        } else {
            res.send(`<script>alert("This department doesn't exist"); location.href="/enter/edit"</script>`)
        }
    }

    //doctor
    else if (req.cookies.user[1] == "doctor") {
        const data = {
            details: vars.details,
            date: vars.date,
            doctor: req.cookies.user[0],
            oldDate: vars.oldDate
        }
        await updateSql.updateExamination(data);
        res.redirect('/enter/edit');
    }

    //nurse
    else if (req.cookies.user[1] == "nurse") {
        const data = {
            details: vars.details,
            date: vars.date,
            nurse: req.cookies.user[0],
            oldDate: vars.oldDate
        }
        console.log(data);
        await updateSql.updateTreatment(data);
        res.redirect('/enter/edit');
    }

};

exports.delete = async (req, res) => {
    const id = req.params.id;

    //admin
    if (req.cookies.user[1] == "admin") {
        const role = req.params.role;
        if (role == "doctor") await deleteSql.deleteDoctor(id)
        else if (role == "nurse") await deleteSql.deleteNurse(id)
        res.redirect('/enter/edit')
    }

    //doctor
    else if (req.cookies.user[1] == "doctor") {
        await deleteSql.deleteExamination(id)
        res.redirect('/enter/edit')
    }

    //nurse
    else if (req.cookies.user[1] == "nurse") {
        await deleteSql.deleteTreatment(id)
        res.redirect('/enter/edit')
    }

    //patient
    else if (req.cookies.user[1] == "patient") {
        await deleteSql.deleteReservation(id)
        res.redirect('/enter/edit')
    }
}

exports.insertPage = async (req, res) => {
    //admin
    if (req.cookies.user[1] == "admin") {
        const role = req.params.role;
        const departments = await selectSql.getDeartmentName();
        if (role == "doctor") res.render('insertDoctor', { departments });
        else if (role == "nurse") res.render('insertNurse', { departments });
        else res.redirect('/enter/edit');
    }

    //doctor
    else if (req.cookies.user[1] == "doctor") {
        const doctors = await selectSql.getDoctorName();
        const patients = await selectSql.getPatientName();
        res.render('insertExamination', { patients, doctors });
    }

    //nurse
    else if (req.cookies.user[1] == "nurse") {
        const nurses = await selectSql.getNurseName();
        const patients = await selectSql.getPatientName();
        res.render('insertTreatment', { nurses, patients });
    }

    else if (req.cookies.user[1] == "patient") {
        const departments = await selectSql.getDeartmentName();
        const patients = await selectSql.getPatientName();
        res.render('insertReservation', { departments, patients });
    }
}

exports.insert = async (req, res) => {
    const vars = req.body;
    if (req.cookies.user[1] == "admin") {
        const role = req.params.role;
        if (role == "doctor") await insertSql.setDoctor(vars)
        else if (role == "nurse") await insertSql.setNurse(vars)
        res.redirect('/enter/edit')
    }

    else if (req.cookies.user[1] == "doctor") {
        vars.doctorId = req.cookies.user[0]
        await insertSql.setExamination(vars)
        res.redirect('/enter/edit')
    }

    else if (req.cookies.user[1] == "nurse") {
        vars.nurseId = req.cookies.user[0]
        await insertSql.setTreatment(vars)
        res.redirect('/enter/edit')
    }

    else if (req.cookies.user[1] == "patient") {
        vars.patientId = req.cookies.user[0]
        await insertSql.setReservation(vars)
        res.redirect('/enter/edit')
    }
}

exports.search = async (req, res) => {
    const vars = req.body;
    const type = req.params.type;
    const patient = await selectSql.getPatientDetails(vars.name)
   
    if(type == "examination"){
        const Examination = await selectSql.getExamination(req.cookies.user[0]);
        res.render('examination', {
            title1: "Examination",
            Examination,
            patient
        })
    }

    else if(type == "treatment"){
        const Treatment = await selectSql.getTreatment(req.cookies.user[0]);
        res.render('treatment', {
            title1: "Treatment",
            Treatment,
            patient
        })
    }
}