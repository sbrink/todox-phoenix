import 'phoenix_html';
import $ from 'jquery';

$(() => {
  $(document).on('change', '.todo-item-done-ajax', (event) => {
    const checkbox = $(event.target);
    const tableRow = checkbox.closest('tr');
    const done = checkbox.prop('checked');
    const id = checkbox.data('id');

    $.ajax({
      url: `/api/todo_items/${id}/toggle`,
      method: 'patch',
      data: { done: done },
      dataType: 'json',

      success: (response) => {
        tableRow.toggleClass('done', response.todoItem.done);
      }
    })
  });
});
