/*
Mock Interview 2)

Question:

-- 1) Find the date with the highest total energy consumption from our datacenters.
-- 2) Output the date along with the total engery consumption across all datacenters.

-- Table: eu_energy
date			datetime
consumption		int
	
-- Table: asia_energy
date			datetime
consumption		int

-- Table: na_energy
date			datetime
consumption		int

*/

/******

Always make sure you under the tables and columns correctly. Ask the interviewer if you need to make any assumptions
on the columns data, etc.

1) So there are 3 tables representing energy consumptions across different continents. 
Can I assume that there is only one energy consumption for each particular date Or can there be a multiple consumptions
for a specific date? Is there any possible missing values too?

We can just sum it up across different dates across the different tables.
*****/


/*
Question: What would you do if in the first table there are two of the same dates with
different energy consumptions?

Possibe Answer: 
Then we can just group by using Date and sum the engery consumptions.
*/


/****

Clarification Question back to Interviwer:
Is there a situation that there are Multiple Dates with the same highest Total Energy Consumption?
****/

