const { selectSql } = require("../database/sql");

exports.renderPage = (req, res, next) => {
    if (req.cookies.user) {
        res.redirect('/enter/edit')
    } else {
        res.render('login');
    }
};

exports.logout = (req, res) => {
    if (req.cookies.user) {
        res.clearCookie('user')
        res.redirect("/");
    } else {
        res.redirect("/");
    }
}

exports.checkLogin = async (req, res) => {
    const adminU = process.env.admin_username
    const adminP = process.env.admin_password

    const vars = req.body;
    const users = [];
    const doctor = await selectSql.getDoctor();
    const nurse = await selectSql.getNurse();
    const patient = await selectSql.getPatient();
    users.push(...doctor, ...nurse, ...patient)

    let id;
    let checkLogin = false;
    let isAdmin = false
    let role;
    let whoAmI = []
    
    if (vars.id == adminU && vars.password == adminP) {
        checkLogin = true;
        id = adminU
        isAdmin = true
        role = "admin"
    }

    if(!isAdmin){
        users.forEach((user) => {
            if (vars.id == user.doctor_id && vars.password == user.password) {
                checkLogin = true;
                id = user.doctor_id;
                role = "doctor"
                return 
            } else if (vars.id == user.nurse_id && vars.password == user.password) {
                checkLogin = true;
                id = user.nurse_id;
                role = "nurse"
                return
            } else if (vars.id == user.patient_id && vars.password == user.password) {
                checkLogin = true;
                id = user.patient_id;
                role = "patient"
                return 
            }
        })
    }

    whoAmI.push(id,role)

    if (checkLogin) {
        res.cookie('user', whoAmI, {
            expires: new Date(Date.now() + 3600000),
            httpOnly: true
        })
        res.redirect('/');
    } else {
        res.redirect('/');
    }
}