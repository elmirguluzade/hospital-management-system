create index doctor_name on doctor(name)
create index nurse_name_idx on nurse(name)
create index patient_name_idx on patient(name)
create index examination_details_idx on examination(examination_details)
create index treatment_details_idx on treatment(treatment_details)

select * from doctor where name="Dr Smith";
select * from nurse where name="Nurse Smith";
select * from patient where name="Dr Smith";
select * from examination where examination_details="Check Up";
select * from treatment where name="Dr Smith";

show indexes from doctor
show indexes from nurse
show indexes from patient
show indexes from examination
show indexes from treatment