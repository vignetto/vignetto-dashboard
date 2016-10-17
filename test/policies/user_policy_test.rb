require 'test_helper'

class UserPolicyTest < ActiveSupport::TestCase
  def setup
    @admin = users(:admin_user)
    @admin_other = users(:admin_2_user)
    @host = users(:host_user)
    @participant = users(:participant_user)

    @admin_admin_policy = UserPolicy.new @admin, @admin
    @admin_host_policy = UserPolicy.new @admin, @host
    @admin_participant_policy = UserPolicy.new @admin, @participant
    @host_admin_policy = UserPolicy.new @host, @admin
    @host_host_policy = UserPolicy.new @host, @host
    @host_participant_policy = UserPolicy.new @host, @participant
    @participant_admin_policy = UserPolicy.new @participant, @admin
    @participant_participant_policy = UserPolicy.new @participant, @participant
    @participant_host_policy = UserPolicy.new @participant, @host
    @admin_admin_other_policy = UserPolicy.new @admin, @admin_other
  end

  # index?
  def test_admin_can_view_index
    assert @admin_participant_policy.index?  
  end
  def test_host_cant_view_index
    refute @host_participant_policy.index?  
  end
  def test_participant_cant_view_index
    refute @participant_participant_policy.index?  
  end

  # show?
  def test_admin_can_view_own_account
    assert @admin_admin_policy.show?  
  end
  def test_admin_can_view_host_user_account
    assert @admin_host_policy.show?  
  end
  def test_admin_can_view_participant_user_account
    assert @admin_participant_policy.show?  
  end
  def test_host_cant_view_admin_account
    refute @host_admin_policy.show?  
  end
  def test_host_cant_view_participant_account
    refute @host_participant_policy.show?  
  end
  def test_host_can_view_own_account
    assert @host_host_policy.show?  
  end
  def test_participant_cant_view_admin_account
    refute @participant_admin_policy.show?  
  end
  def test_participant_cant_view_host_account
    refute @participant_host_policy.show?  
  end
  def test_participant_can_view_own_account
    assert @participant_participant_policy.show?  
  end

  # update?
  def test_admin_can_update_own_account
    assert @admin_admin_policy.update?  
  end
  def test_admin_can_update_host_user_account
    assert @admin_host_policy.update?  
  end
  def test_admin_can_update_participant_user_account
    assert @admin_participant_policy.update?  
  end
  def test_host_cant_update_admin_account
    refute @host_admin_policy.update?  
  end
  def test_host_cant_update_participant_account
    refute @host_participant_policy.update?  
  end
  def test_host_can_update_own_account
    assert @host_host_policy.update?  
  end
  def test_participant_cant_update_admin_account
    refute @participant_admin_policy.update?  
  end
  def test_participant_cant_update_host_account
    refute @participant_host_policy.update?  
  end
  def test_participant_can_update_own_account
    assert @participant_participant_policy.update?  
  end

  # destroy?
  def test_admin_cant_destroy_own_account
    refute @admin_admin_policy.destroy?  
  end
  def test_admin_can_destroy_other_account
    assert @admin_admin_other_policy.destroy?  
  end
  def test_admin_can_destroy_host_user_account
    assert @admin_host_policy.destroy?  
  end
  def test_admin_can_destroy_participant_user_account
    assert @admin_participant_policy.destroy?  
  end
  def test_host_cant_destroy_admin_account
    refute @host_admin_policy.destroy?  
  end
  def test_host_cant_destroy_participant_account
    refute @host_participant_policy.destroy?  
  end
  def test_host_cant_destroy_own_account
    refute @host_host_policy.destroy?  
  end
  def test_participant_cant_destroy_admin_account
    refute @participant_admin_policy.destroy?  
  end
  def test_participant_cant_destroy_host_account
    refute @participant_host_policy.destroy?  
  end
  def test_participant_cant_destroy_own_account
    refute @participant_participant_policy.destroy?  
  end

end
