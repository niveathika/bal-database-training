import training.insert;

configurable string host = ?;
configurable int port = ?;
configurable string username = ?;
configurable string password = ?;
configurable string database = ?;

public function main() {
    insert:main(host, port, username, password, database);
}
