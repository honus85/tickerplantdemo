h:hopen 5010
trade:([]time:`timespan$();sym:`symbol$();price:`float$();size:`int$())
trade_replica:([]time:`timespan$();sym:`symbol$();price:`float$();size:`int$())
sum_size:{[t] select sum size by sym from t} 
totaltradesize:sum_size[trade]
upd:{[tabname;tabdata] tabname insert (tabdata)}
h(`.u.sub;`;`) 
UPD:upd

upd:{[t;x] UPD[t;x] ; UPD[`trade_replica;x]; `totaltradesize upsert sum_size[t]}

