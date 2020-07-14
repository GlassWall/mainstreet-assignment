require "test_helper"
require "application_system_test_case"
require 'minitest/byebug' if ENV['DEBUG']
class CompaniesControllerTest < ApplicationSystemTestCase

  def setup
    @company = companies(:hometown_painting)
  end

  test "Index" do
    visit companies_path

    assert_text "Companies"
    assert_text "Hometown Painting"
    assert_text "Wolf Painting"
    assert_text "Delete"
  end

  test "Show" do
    visit company_path(@company)

    assert_text @company.name
    assert_text @company.phone
    assert_text @company.email
    assert_text "Ventura, California"
  end

  test "Update" do
    visit edit_company_path(@company)

    within("form#edit_company_#{@company.id}") do
      fill_in("company_name", with: "Updated Test Company")
      fill_in("company_zip_code", with: "93009")
      click_button "Update Company"
    end

    assert_text "Changes Saved"

    @company.reload
    assert_equal "Updated Test Company", @company.name
    assert_equal "93009", @company.zip_code
  end
  
  test "Update with invalid email" do
    visit edit_company_path(@company)

    within("form#edit_company_#{@company.id}") do
      fill_in("company_name", with: "Updated Test Company")
      fill_in("company_zip_code", with: "93009")
      fill_in("company_email", with: "new_test_company@random.com")
      click_button "Update Company"
    end

    assert_text "Email should end with @getmainstreet.com"

    @company.reload
    assert_not_equal "Updated Test Company", @company.name
    assert_not_equal "93009", @company.zip_code
  end

  test "Create" do
    visit new_company_path

    within("form#new_company") do
      fill_in("company_name", with: "New Test Company")
      fill_in("company_zip_code", with: "28173")
      fill_in("company_phone", with: "5553335555")
      fill_in("company_email", with: "new_test_company@getmainstreet.com")
      click_button "Create Company"
    end

    assert_text "Saved"

    last_company = Company.last
    assert_equal "New Test Company", last_company.name
    assert_equal "28173", last_company.zip_code
  end

  test "Create with invalid Email" do
    visit new_company_path

    within("form#new_company") do
      fill_in("company_name", with: "New Test Company")
      fill_in("company_zip_code", with: "28173")
      fill_in("company_phone", with: "5553335555")
      fill_in("company_email", with: "new_test_company@random.com")
      click_button "Create Company"
    end
    assert_text "Email should end with @getmainstreet.com"
    last_company = Company.last
    assert_not_equal "New Test Company", last_company.name
    assert_not_equal "28173", last_company.zip_code
  end

  test "Delete" do
    visit companies_path
    assert_equal(Company.count,6)
    first('.del').click
    page.driver.browser.switch_to.alert.accept
    sleep(1)
    assert_equal(Company.count, 5)
  end
end
