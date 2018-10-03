require 'test_helper'

class TranTest < ActiveSupport::TestCase

  setup do
    @user = users(:one)
    @user2 = users(:two)
  end

  test "transfer" do
	assert Tran.balance(@user) == 0
	assert Tran.balance(@user2) == 0
	Tran.credit(@user, 100.55)
	assert Tran.transfer(@user, @user2, 0.55) == true
	assert Tran.balance(@user) == 100
	assert Tran.balance(@user2) == 0.55
  end

  test "can not do self transfer" do
	assert Tran.transfer(@user, @user, 10) == nil
	Tran.credit(@user, 100)
	assert Tran.balance(@user) == 100
	assert Tran.transfer(@user, @user, 10) == nil
	assert Tran.balance(@user) == 100
  end

  test "invalid transfer with no balance" do
	assert Tran.balance(@user) == 0
	assert Tran.balance(@user2) == 0
	assert Tran.transfer(@user, @user2, 0.55) == nil
	assert Tran.balance(@user) == 0
	assert Tran.balance(@user2) == 0
  end

  test "invalid transfer amount < 0" do
	assert Tran.balance(@user) == 0
	Tran.credit(@user, 100)
	assert Tran.balance(@user) == 100
	assert Tran.balance(@user2) == 0
	assert Tran.transfer(@user, @user2, -0.55) == nil
	assert Tran.balance(@user) == 100
	assert Tran.balance(@user2) == 0
  end

  test "balance" do
	assert Tran.balance(@user) == 0
	Tran.credit(@user, 1.56)
	assert Tran.balance(@user) == 1.56
  end

  test "invalid balance query" do
	assert Tran.balance(nil) == nil
  end

  test "credit" do
	assert Tran.balance(@user) == 0
	assert Tran.credit(@user, 0.1) != nil
	assert Tran.balance(@user) == 0.1
  end

  test "invalid credit" do
	assert Tran.credit(@user, 0) == nil
	assert Tran.credit(@user, -0.1) == nil
	assert Tran.balance(@user) == 0
	assert Tran.credit(nil, 10.1) == nil
  end

  test "debit" do
	Tran.credit(@user, 1000)
	assert Tran.debit(@user, 200) != nil
	assert Tran.balance(@user) == 800
	assert Tran.debit(@user, 0.45) != nil
	assert Tran.balance(@user) == 799.55 
  end

  test "invalid debit" do
	assert Tran.balance(@user) == 0
	assert Tran.debit(@user, 1) == nil
	assert Tran.debit(@user, -1) == nil
	Tran.credit(@user, 1000)
	assert Tran.debit(@user, -1) == nil
	assert Tran.debit(nil, -1) == nil
  end

end
