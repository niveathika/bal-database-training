import ballerina/log;
import ballerina/sql;
import ballerinax/mysql;
import ballerinax/mysql.driver as _;
import ballerina/time;

configurable string host = ?;
configurable int port = ?;
configurable string username = ?;
configurable string password = ?;
configurable string database = ?;

public function main() returns error? {
    mysql:Client dbClient = check new mysql:Client(host, username, password, database, port);
    check insertCandidate(dbClient);
    check dbClient.close();
}

function insertCandidate(mysql:Client dbClient) returns sql:Error? {
    time:Date dob = {
        year: 1990,
        month: 1,
        day: 1
    };
    sql:ParameterizedQuery query = `INSERT INTO candidates(first_name, last_name, dob) VALUES('Harry', 'Potter', ${dob});`;
    sql:ExecutionResult result = check dbClient->execute(query);

    int lastInsertId = <int> result.lastInsertId;
    log:printInfo(string `Insert Success, id: ${lastInsertId}`);
}