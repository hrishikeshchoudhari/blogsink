defmodule Blogsink.SchoolTest do
  use Blogsink.DataCase

  alias Blogsink.School

  describe "students" do
    alias Blogsink.School.Student

    import Blogsink.SchoolFixtures

    @invalid_attrs %{name: nil, origin: nil}

    test "list_students/0 returns all students" do
      student = student_fixture()
      assert School.list_students() == [student]
    end

    test "get_student!/1 returns the student with given id" do
      student = student_fixture()
      assert School.get_student!(student.id) == student
    end

    test "create_student/1 with valid data creates a student" do
      valid_attrs = %{name: "some name", origin: "some origin"}

      assert {:ok, %Student{} = student} = School.create_student(valid_attrs)
      assert student.name == "some name"
      assert student.origin == "some origin"
    end

    test "create_student/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = School.create_student(@invalid_attrs)
    end

    test "update_student/2 with valid data updates the student" do
      student = student_fixture()
      update_attrs = %{name: "some updated name", origin: "some updated origin"}

      assert {:ok, %Student{} = student} = School.update_student(student, update_attrs)
      assert student.name == "some updated name"
      assert student.origin == "some updated origin"
    end

    test "update_student/2 with invalid data returns error changeset" do
      student = student_fixture()
      assert {:error, %Ecto.Changeset{}} = School.update_student(student, @invalid_attrs)
      assert student == School.get_student!(student.id)
    end

    test "delete_student/1 deletes the student" do
      student = student_fixture()
      assert {:ok, %Student{}} = School.delete_student(student)
      assert_raise Ecto.NoResultsError, fn -> School.get_student!(student.id) end
    end

    test "change_student/1 returns a student changeset" do
      student = student_fixture()
      assert %Ecto.Changeset{} = School.change_student(student)
    end
  end
end
