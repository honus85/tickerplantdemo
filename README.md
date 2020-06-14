# tickerplantdemo
tickerplant usage

This is a demo of how to use kdb+ ticker plant.
Setup windows folder structure as

q <br /> 
--|q <br /> 
----|w64 <br /> 
------|q.exe <br /> 
----|tick <br /> 
 ------|r.q <br /> 
 ------|u.q <br /> 
 ------|sym.q   <br /> 
--|tick.q <br /> 
--|publisher.q <br /> 
--|tickerplant.q <br /> 
--|subscriber.q <br /> 

Open files in three separate q processes

Explanation

-tickerplant
  - opens port to accept connections from
  - load tick.q (source available from https://github.com/KxSystems/kdb-tick; Be sure to load sym.q available from https://github.com/KxSystems/kdb/tree/master/tick)
  - .u.init[] to initialise tickerplant from the sym.q empty structure file
  - use .u.w to check subscribed handles (should be empty to start with)
 
 -subcriber
   - (line 1) h:hopen to start connection to tickerplant
   - (line 2) setup trade table, should be same as tickerplant
   - (line 3) setup trade replica table (purpose to demonstrate multiple table updates)
   - (line 4) setup function to sum size by symbol
   - (line 5) atom to store data from above function
   - (line 6) define upd function that is called by tickerplant when data needs to be pushed to subscriber
              simply insert table data into table name (matches source and destination, but can be changed to liking)
   - (line 7) subscribe to publisher
   - (line 8) take backup of upd function
   - (line 9) demonstrates the ability to chain functions when update is received:
              "upon data arrival, call insert to destination table same name as source, then insert same data into replica table
              then upsert to totaltradesize the summation function"
   
 -publisher
   - this is a simple publisher component, it can also be written in c/java/python etc 
   - h:hopen to open port to ticker plant
   - call the .u.upd to insert data via tickerplant to subscribing members. Note: there is no need to supply a timestamp
   
Todo: In this archtitecture the tickerplant is listener to publisher, and also provides subscription, it is possible to chain the tickerplant to avoid subscribers overloading the main tickerplant

   
