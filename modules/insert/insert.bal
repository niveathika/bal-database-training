import ballerina/log;
import ballerina/sql;
import ballerinax/mysql;
import ballerinax/mysql.driver as _;
import ballerina/time;

public function main(string host, int port, string username, string password, string database) returns error? {
    mysql:Client dbClient = check new mysql:Client(host, username, password, database, port);
    check insertCandidates(dbClient);
    check dbClient.close();
}

function insertCandidates(mysql:Client dbClient) returns sql:Error? {
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

