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
	Tran.transfer(@user, @user2, 0.55)
	assert Tran.balance(@user) == 100
	assert Tran.balance(@user2) == 0.55
  end

  test "balance" do
	assert Tran.balance(@user) == 0
	Tran.credit(@user, 1.56)
	assert Tran.balance(@user) == 1.56
  end

  test "credit" do
	Tran.credit(@user, 0.1)
	assert Tran.balance(@user) == 0.1
  end

  test "debit" do
	Tran.credit(@user, 1000)
	Tran.debit(@user, 200)
	assert Tran.balance(@user) == 800
  end

end
