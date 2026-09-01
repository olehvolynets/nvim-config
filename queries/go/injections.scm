(call_expression
  function: (selector_expression
    field: (field_identifier) @method
      (#any-of? @method "Exec" "ExecContext"
                        "Query" "QueryContext"
                        "QueryRow" "QueryRowContext"
                        "Prepare" "PrepareContext"))

  arguments: (argument_list [
      (raw_string_literal (raw_string_literal_content) @injection.content)
      (interpreted_string_literal (interpreted_string_literal_content) @injection.content)
    ] (#set! injection.language "sql")))

;; extend
(
    [
        ((interpreted_string_literal
            (interpreted_string_literal_content) @injection.content) . (comment) @_lang)
        ((raw_string_literal
            (raw_string_literal_content) @injection.content) . (comment) @_lang)
        ((expression_statement
            [
                (interpreted_string_literal
                    (interpreted_string_literal_content) @injection.content)
                (raw_string_literal
                    (raw_string_literal_content) @injection.content)
            ]) . (comment) @_lang)

    ]
    (#match? @_lang "[sS][qQ][lL]")
    (#set! injection.language "sql")
)

(
    [
        (raw_string_literal (raw_string_literal_content) @injection.content) @_str
        (interpreted_string_literal (interpreted_string_literal_content) @injection.content) @_str
    ]
    (#has-ancestor? @injection.content const_spec var_spec)
    (#has-sql-comment? @injection.content)
    (#set! injection.language "sql")
    (#set! priority 200)
)

; FIX doesn't work in expressions like:
; MyStruct{"select * from ..." /* lang: sql */}
; MyStruct{Field: "select * from ..." /* lang: sql */}
