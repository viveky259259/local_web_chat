String insertUser = """
    mutation MyMutation(\$user: [user_insert_input!]!) {
        insert_user(objects: \$user) {
          affected_rows
          returning {
            zipcode
            updated_at
            name
            mobile
            location
            lng
            lat
            is_deleted
            is_authenticated
            is_active
            id
            created_at
          }
        }
      }
""";

/*
[insertUser]
{
  "user":{
   "name":"Vivek",
    "mobile": "7021730766"
  }
}
 */
