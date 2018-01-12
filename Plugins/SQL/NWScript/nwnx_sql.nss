#include "nwnx"

// Prepares the provided query for execution. Does not execute it! Clears any previous state.
// Returns TRUE if the query was successfully prepared.
int NWNX_SQL_PrepareQuery(string query);

// Executes a query which has been prepared.
// Returns the ID of this query if successful, else FALSE.
int NWNX_SQL_ExecutePreparedQuery();

// Directly execute an SQL query. Clears previously prepared query states.
// Returns the ID of this query if successful, else FALSE.
int NWNX_SQL_ExecuteQuery(string query);

// Returns TRUE if one or more rows are ready, FALSE otherwise.
int NWNX_SQL_ReadyToReadNextRow();

// Reads the next row of returned data.
// Should only be called after a successsful call to NWNX_SQL_ReadyToReadNextRow().
void NWNX_SQL_ReadNextRow();

// Returns data at the nth (0-based) column of the active row.
// NWNX_SQL_ReadNextRow should be called before this.
string NWNX_SQL_ReadDataInActiveRow(int column = 0);

// Set the int value of a prepared statement at given position
void NWNX_SQL_PreparedInt(int position, int value);
// Set the string value of a prepared statement at given position
void NWNX_SQL_PreparedString(int position, string value);
// Set the float value of a prepared statement at given position
void NWNX_SQL_PreparedFloat(int position, float value);
// Set the objectID value of a prepared statement at given position
void NWNX_SQL_PreparedObjectId(int position, object value);
// Set the full serialized object value of a prepared statement at given position
void NWNX_SQL_PreparedObjectFull(int position, object value);

// Like NWNX_SQL_ReadDataInActiveRow, but for full serialized objects.
// The object will be deserialized and created in the game. New object ID is returned.
// If the deserialized object is an item, owner object must be specified:
//    - If the owner is a placeable, creature or container, the item will be created in its inventory
//    - If the owner is an area, the item will be created on the ground at Vector(x,y,z);
object NWNX_SQL_ReadFullObjectInActiveRow(int column = 0, object owner = OBJECT_INVALID, float x = 0.0, float y = 0.0, float z = 0.0);

// Return number of rows affected by SQL statement (for non-row-based statements like INSERT, UPDATE, DELETE, etc.);
// Returns -1 if the query was not non-row-based.
int NWNX_SQL_GetAffectedRows();

// Return the database type we're interacting with (same value as the value of NWNX_SQL_TYPE environment var)
string NWNX_SQL_GetDatabaseType();

int NWNX_SQL_PrepareQuery(string query)
{
    NWNX_PushArgumentString("NWNX_SQL", "PREPARE_QUERY", query);
    NWNX_CallFunction("NWNX_SQL", "PREPARE_QUERY");
    return NWNX_GetReturnValueInt("NWNX_SQL", "PREPARE_QUERY");
}

int NWNX_SQL_ExecutePreparedQuery()
{
    NWNX_CallFunction("NWNX_SQL", "EXECUTE_PREPARED_QUERY");
    return NWNX_GetReturnValueInt("NWNX_SQL", "EXECUTE_PREPARED_QUERY");
}

int NWNX_SQL_ExecuteQuery(string query)
{
    // Note: the implementation might change as support for more SQL targets arrives.
    if (NWNX_SQL_PrepareQuery(query))
        return NWNX_SQL_ExecutePreparedQuery();

    return FALSE;
}

int NWNX_SQL_ReadyToReadNextRow()
{
    NWNX_CallFunction("NWNX_SQL", "READY_TO_READ_NEXT_ROW");
    return NWNX_GetReturnValueInt("NWNX_SQL", "READY_TO_READ_NEXT_ROW");
}

void NWNX_SQL_ReadNextRow()
{
    NWNX_CallFunction("NWNX_SQL", "READ_NEXT_ROW");
}

string NWNX_SQL_ReadDataInActiveRow(int column = 0)
{
    NWNX_PushArgumentInt("NWNX_SQL", "READ_DATA_IN_ACTIVE_ROW", column);
    NWNX_CallFunction("NWNX_SQL", "READ_DATA_IN_ACTIVE_ROW");
    return NWNX_GetReturnValueString("NWNX_SQL", "READ_DATA_IN_ACTIVE_ROW");
}


void NWNX_SQL_PreparedInt(int position, int value)
{
    NWNX_PushArgumentInt("NWNX_SQL", "PREPARED_INT", value);
    NWNX_PushArgumentInt("NWNX_SQL", "PREPARED_INT", position);
    NWNX_CallFunction("NWNX_SQL", "PREPARED_INT");
}
void NWNX_SQL_PreparedString(int position, string value)
{
    NWNX_PushArgumentString("NWNX_SQL", "PREPARED_STRING", value);
    NWNX_PushArgumentInt("NWNX_SQL", "PREPARED_STRING", position);
    NWNX_CallFunction("NWNX_SQL", "PREPARED_STRING");

}
void NWNX_SQL_PreparedFloat(int position, float value)
{
    NWNX_PushArgumentFloat("NWNX_SQL", "PREPARED_FLOAT", value);
    NWNX_PushArgumentInt("NWNX_SQL", "PREPARED_FLOAT", position);
    NWNX_CallFunction("NWNX_SQL", "PREPARED_FLOAT");

}
void NWNX_SQL_PreparedObjectId(int position, object value)
{
    NWNX_PushArgumentObject("NWNX_SQL", "PREPARED_OBJECT_ID", value);
    NWNX_PushArgumentInt("NWNX_SQL", "PREPARED_OBJECT_ID", position);
    NWNX_CallFunction("NWNX_SQL", "PREPARED_OBJECT_ID");

}
void NWNX_SQL_PreparedObjectFull(int position, object value)
{
    NWNX_PushArgumentObject("NWNX_SQL", "PREPARED_OBJECT_FULL", value);
    NWNX_PushArgumentInt("NWNX_SQL", "PREPARED_OBJECT_FULL", position);
    NWNX_CallFunction("NWNX_SQL", "PREPARED_OBJECT_FULL");
}

object NWNX_SQL_ReadFullObjectInActiveRow(int column = 0, object owner = OBJECT_INVALID, float x = 0.0, float y = 0.0, float z = 0.0)
{
    NWNX_PushArgumentFloat("NWNX_SQL", "READ_FULL_OBJECT_IN_ACTIVE_ROW", z);
    NWNX_PushArgumentFloat("NWNX_SQL", "READ_FULL_OBJECT_IN_ACTIVE_ROW", y);
    NWNX_PushArgumentFloat("NWNX_SQL", "READ_FULL_OBJECT_IN_ACTIVE_ROW", x);
    NWNX_PushArgumentObject("NWNX_SQL", "READ_FULL_OBJECT_IN_ACTIVE_ROW", owner);
    NWNX_PushArgumentInt("NWNX_SQL", "READ_FULL_OBJECT_IN_ACTIVE_ROW", column);
    NWNX_CallFunction("NWNX_SQL", "READ_FULL_OBJECT_IN_ACTIVE_ROW");
    return NWNX_GetReturnValueObject("NWNX_SQL", "READ_FULL_OBJECT_IN_ACTIVE_ROW");
}

int NWNX_SQL_GetAffectedRows() 
{
    NWNX_CallFunction("NWNX_SQL", "GET_AFFECTED_ROWS");
    return NWNX_GetReturnValueInt("NWNX_SQL", "GET_AFFECTED_ROWS");
}

string NWNX_SQL_GetDatabaseType()
{
    NWNX_CallFunction("NWNX_SQL", "GET_DATABASE_TYPE");
    return NWNX_GetReturnValueString("NWNX_SQL", "GET_DATABASE_TYPE");
}
    

