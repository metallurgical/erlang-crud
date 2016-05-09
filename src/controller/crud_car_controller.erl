-module( crud_car_controller, [ Req ] ).
-compile( export_all ).

list ( 'GET', [] ) ->
	Car = boss_db:find( car, [] ),
	{ ok, [{ cars, Car }]}.

create ( 'GET', [] ) ->
	ok;
create ( 'POST', [] ) ->
	Type  = Req:post_param( "type" ),
	Color = Req:post_param( "color" ),
	NewCar   = car:new( id, Type, Color ),
	{ ok, NewCarSucc } = NewCar:save(),
	{ redirect, [{ action, "list" }]}.

delete ( 'GET', [ Id ] ) ->
	boss_db:delete( Id ),
	{ redirect, [{ action, "list" }]}.

update ( 'GET', [ Id ] ) ->
	Car = boss_db:find( Id ),
	{ ok, [{ car, Car }]};
update ( 'POST', [] ) ->
	Type     = Req:post_param( "type" ),
	Color    = Req:post_param( "color" ),
	Id       = Req:post_param( "id" ),
	NCar      = boss_db:find( Id ),
	NewTypeCar  = NCar:set( [{type, Type}, {color, Color}]),
	{ ok, NewCarSucc } = NewTypeCar:save(),
	{ redirect, [{ action, "list" }]}.

