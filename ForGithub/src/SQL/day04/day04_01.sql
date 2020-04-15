select @@global.autocommit, @@autocommit, @@global.transaction_isolation, @@transaction_isolation;

# mysql workbench에서는 기본 transaction_isolation = repeatable-read
set transaction_isolation='read-committed';

# DAO = Data Access Object - SQL 단위의 처리를 담당 -TX와 무관
# Service Layer - 업무 단위의 처리 - 여러개의 DAO 메서드 호출 -TX 처리


