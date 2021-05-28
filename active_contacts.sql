SELECT 
AccountId, 
Name, 
CreatedDate
FROM Contact 
WHERE AccountId IN (select Id from Account where CustomerId != null) 
AND Status = 'Active' 
AND Name != null
