-- Problem 1
select CustNo, CustFirstName, CustLastName, CustCity
from Customer
where Customer.CustNo IN 
    (select CustNo from OrderTbl 
    where CustBal > 150
            AND to_char(OrdDate, 'MM/YYYY') = '02/2013' );

-- Problem 3
select ProdNo, ProdName, ProdPrice
from Product
where Product.ProdPrice IN
    (select ProdPrice from Product
    where ProdPrice > 150
        AND Product.ProdNo IN
        (select ProdNo from OrdLine
        where Product.ProdNo = OrdLine.ProdNo
        AND OrdNo IN
        (select OrdNo from OrderTbl
        where to_char(OrdDate, 'MM/DD/YYYY') = '01/23/2013'  )));

-- Problem 5
select ot.OrdNo, ot.OrdDate, emp.EmpNo, emp.EmpFirstName, emp.EmpLastName
from OrderTbl ot full outer join Employee emp on ot.EmpNo = emp.EmpNo
where to_char(OrdDate, 'MM/DD/YYYY') = '01/23/2013';

-- Problem 6
select ot.OrdNo, ot.OrdDate, emp.EmpNo, emp.EmpFirstName, 
    emp.EmpLastName, c.CustNo, c.CustFirstName, c.CustLastName
from OrderTbl ot full outer join Employee emp on ot.EmpNo = emp.EmpNo
full outer join Customer c on c.CustNo = ot.CustNo
where to_char(OrdDate, 'MM/DD/YYYY') = '01/23/2013';

-- Problem 9
select CustNo, CustFirstName, CustLastName
from Customer
where NOT EXISTS 
    (select CustNo from OrderTbl
    where Customer.CustNo = OrderTbl.CustNo
    AND to_char(OrdDate, 'MM/YYYY') = '02/2013')
    AND CustState = 'CO'
    order by CustNo asc;

-- Problem 22
delete from OrderTbl 
where OrderTbl.CustNo IN
    (select CustNo from Customer
        where CustFirstName = 'Betty'
        AND CustLastName = 'Wise'
        AND OrderTbl.CustNo = Customer.CustNo
        AND to_char(OrdDate, 'MM/YYYY') = '01/2013'  );
