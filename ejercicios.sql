create database transacciones;
\c transacciones;

create table cuentas (numero_cuenta int not null unique primary key, balance float
check(balance >= 0.00));

insert into cuentas (numero_cuenta, balance) values (1, 1000);
insert into cuentas (numero_cuenta, balance) values (2, 1000);

begin transaction;
    UPDATE cuentas set balance = balance - 1000 where numero_cuenta = 1 returning *;
    UPDATE cuentas set balance = balance + 1000 where numero_cuenta = 2 returning *;

    select * from cuentas;
commit;

insert into cuentas (numero_cuenta, balance) values (3, 1000);

begin transaction;
    UPDATE cuentas set balance = balance - 1000 where numero_cuenta = 3;
    UPDATE cuentas set balance = balance + 1000 where numero_cuenta = 1;

    select * from cuentas;
ROLLBACK;



begin transaction;

    insert into cuentas (numero_cuenta, balance) values (4, 1000);
    insert into cuentas (numero_cuenta, balance) values (5, 1000);


    UPDATE cuentas set balance = balance - 1000 where numero_cuenta = 2;
    UPDATE cuentas set balance = balance + 1000 where numero_cuenta = 1;

    DELETE FROM cuentas WHERE numero_cuenta IN (1,2);

    select * from cuentas;

ROLLBACK;
