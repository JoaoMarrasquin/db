create or replace function tg_verificar_stock() returns trigger
as
$tg_verificar_stock$
declare 
stock int;
begin
select STOCK_VEHICULO into stock from VEHICULO where vehiculo.id_vehiculo=new.id_vehiculo;
if(stock<=0) then
raise exception 'Este vehiculo ya no cuenta con STOCK';
end if;
return new;
end;
$tg_verificar_stock$
language plpgsql;

create trigger tg_verificar_stock  before insert on venta_factura for each row
execute procedure tg_verificar_stock();
