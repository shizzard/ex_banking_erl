-module(ex_banking_account_tests).

-include_lib("eunit/include/eunit.hrl").
-include("ex_banking_test.hrl").



-spec ?test_spec(test).

%% automatically generated by eunit



-spec ?test_spec(can_get_zero_amount_by_default_test).

can_get_zero_amount_by_default_test() ->
    Account = ex_banking_account:new(<<"USD">>),
    ?assertMatch(0, ex_banking_account:amount(Account)).



-spec ?test_spec(can_get_error_on_invalid_currency_test).

can_get_error_on_invalid_currency_test() ->
    ?assertException(error, function_clause, ex_banking_account:new("USD")).



-spec ?test_spec(can_get_error_on_invalid_initial_amount_test).

can_get_error_on_invalid_initial_amount_test() ->
    ?assertException(error, function_clause, ex_banking_account:new(<<"USD">>, -1)),
    ?assertException(error, function_clause, ex_banking_account:new(<<"USD">>, 1.11)).



-spec ?test_spec(can_get_fields_test).

can_get_fields_test() ->
    Account = ex_banking_account:new(<<"USD">>, 100),
    ?assertMatch(<<"USD">>, ex_banking_account:currency(Account)),
    ?assertMatch(100, ex_banking_account:amount(Account)),
    ?assertMatch(0, ex_banking_account:operations_count(Account)).



-spec ?test_spec(can_plan_deposit_operation_test).

can_plan_deposit_operation_test() ->
    Account = ex_banking_account:new(<<"USD">>),
    {ok, {Operation, Account1}} = ex_banking_account:plan_deposit(Account, 100),
    ?assertMatch(0, ex_banking_account:amount(Account1)),
    ?assertMatch(1, ex_banking_account:operations_count(Account1)),
    ?assertMatch(100, ex_banking_operation:amount(Operation)),
    ?assertMatch(deposit, ex_banking_operation:type(Operation)).



-spec ?test_spec(can_error_on_invalid_deposit_operation_amount_test).

can_error_on_invalid_deposit_operation_amount_test() ->
    Account = ex_banking_account:new(<<"USD">>),
    ?assertException(error, function_clause, ex_banking_account:plan_deposit(Account, -1)),
    ?assertException(error, function_clause, ex_banking_account:plan_deposit(Account, 1.11)).



-spec ?test_spec(can_rollback_deposit_operation_test).

can_rollback_deposit_operation_test() ->
    Account = ex_banking_account:new(<<"USD">>),
    {ok, {Operation, Account1}} = ex_banking_account:plan_deposit(Account, 100),
    {ok, Account2} = ex_banking_account:rollback(Account1, Operation),
    ?assertMatch(0, ex_banking_account:amount(Account2)),
    ?assertMatch(0, ex_banking_account:operations_count(Account2)).



-spec ?test_spec(can_plan_withdraw_operation_test).

can_plan_withdraw_operation_test() ->
    Account = ex_banking_account:new(<<"USD">>, 100),
    {ok, {Operation, Account1}} = ex_banking_account:plan_withdraw(Account, 100),
    ?assertMatch(0, ex_banking_account:amount(Account1)),
    ?assertMatch(1, ex_banking_account:operations_count(Account1)),
    ?assertMatch(100, ex_banking_operation:amount(Operation)),
    ?assertMatch(withdraw, ex_banking_operation:type(Operation)).



-spec ?test_spec(can_error_on_invalid_withdraw_operation_amount_test).

can_error_on_invalid_withdraw_operation_amount_test() ->
    Account = ex_banking_account:new(<<"USD">>),
    ?assertException(error, function_clause, ex_banking_account:plan_withdraw(Account, -1)),
    ?assertException(error, function_clause, ex_banking_account:plan_withdraw(Account, 1.11)).



-spec ?test_spec(can_error_on_withdraw_operation_with_insufficient_funds_test).

can_error_on_withdraw_operation_with_insufficient_funds_test() ->
    Account = ex_banking_account:new(<<"USD">>),
    ?assertMatch({error, not_enough_money}, ex_banking_account:plan_withdraw(Account, 1)).



-spec ?test_spec(can_commit_withdraw_operation_test).

can_commit_withdraw_operation_test() ->
    Account = ex_banking_account:new(<<"USD">>, 100),
    {ok, {Operation, Account1}} = ex_banking_account:plan_withdraw(Account, 100),
    {ok, Account2} = ex_banking_account:commit(Account1, Operation),
    ?assertMatch(0, ex_banking_account:amount(Account2)),
    ?assertMatch(0, ex_banking_account:operations_count(Account2)).



-spec ?test_spec(can_rollback_withdraw_operation_test).

can_rollback_withdraw_operation_test() ->
    Account = ex_banking_account:new(<<"USD">>, 100),
    {ok, {Operation, Account1}} = ex_banking_account:plan_withdraw(Account, 100),
    {ok, Account2} = ex_banking_account:rollback(Account1, Operation),
    ?assertMatch(100, ex_banking_account:amount(Account2)),
    ?assertMatch(0, ex_banking_account:operations_count(Account2)).



-spec ?test_spec(can_error_on_invalid_operation_commit_test).

can_error_on_invalid_operation_commit_test() ->
    Account = ex_banking_account:new(<<"USD">>),
    {ok, {_Operation, Account1}} = ex_banking_account:plan_deposit(Account, 100),
    InvalidOperation = ex_banking_operation:new(deposit, 100),
    ?assertMatch({error, commit_failed}, ex_banking_account:commit(Account1, InvalidOperation)).



-spec ?test_spec(can_error_on_invalid_operation_rollback_test).

can_error_on_invalid_operation_rollback_test() ->
    Account = ex_banking_account:new(<<"USD">>),
    {ok, {_Operation, Account1}} = ex_banking_account:plan_deposit(Account, 100),
    InvalidOperation = ex_banking_operation:new(deposit, 100),
    ?assertMatch({error, rollback_failed}, ex_banking_account:rollback(Account1, InvalidOperation)).
