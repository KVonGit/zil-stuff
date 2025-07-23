var parchmentYonkCss = `.exit-link:not(.disabled), .object-link:not(.disabled){
	cursor: pointer;
}
.droplink{
  color:blue;
}
.droplink:not(.disabled) {
  cursor: pointer;
  text-decoration: underline;
}

.droplink:hover:not(.disabled), .droplink:focus:not(.disabled), .exit-link:hover:not(.disabled) {
  color: blue;
}
/*
.dropdown {
  position: relative;
  display: inline-block;
}
*/
.dropdown-content {
  display: none;
  position: absolute;
  background-color: #f1f1f1;
  overflow: auto;
  border: 1px solid black;
  box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
  z-index: 1;
}

.dropdown-content span {
    color: black;
    padding: 2px;
    text-decoration: none;
    display: block;
    border: 1px solid black;
}

.dropdown  a:hover {
	background-color: #ddd;
}
.dark-body .dropdown  a:hover {
	background-color: #222;
}

.list-link-verb:hover {
	background-color: #ddd;
}
.dark-body .list-link-verb:hover {
	background-color: #222;
} 

.show {
  display:block;
}
.list-link-verb {
	white-space:nowrap;
}
.exit-link:not(.disabled) {
	text-decoration:underline;
}`;

$('head').append('<style>' + parchmentYonkCss + '</style>');

function sendCmd(cmd) {
  $('.dropdown-content').hide();
  $('.Input').val(cmd);
  $('.Input').trigger(jQuery.Event('keypress', {
    key: 'Enter',
    keyCode: 13,
    which: 13
  }));
}

const itemLinks = {
  itemClick(el, event) {
    event.stopPropagation();
    $(el).siblings('.dropdown-content').toggle();
  }
};

function removeObjectLinks() {
  document.querySelectorAll('.object-link').forEach(el => {
    const label = el.firstElementChild?.textContent || el.textContent;
    const textNode = document.createTextNode(label);
    el.replaceWith(textNode);
  });
}

function removeExitLinks() {
  document.querySelectorAll('.exit-link').forEach(el => {
    const label = el.textContent;
    const textNode = document.createTextNode(label);
    el.replaceWith(textNode);
  });
}

const yonk = {};

Object.defineProperty(yonk, 'currentRoom', {
  set(val) {
    if (this._room !== val){
      this._room = val;
      removeObjectLinks();
      removeExitLinks();
    }
  },
  get() {
    return this._room;
  }
});


window.addEventListener('click', function (event) {
  if (!event.target.closest('.dropdown')) {
    document.querySelectorAll('.dropdown-content').forEach(el => {
      el.style.display = 'none';
    });
  }
}, true);

window.addEventListener('keydown', function () {
  document.querySelectorAll('.dropdown-content').forEach(el => {
    el.style.display = 'none';
  });
}, true);

function processNewLines() {
  $('.Style_normal:not(.processed)').each(function () {
    $(this).html($(this).text()).addClass('processed');
  });
}


window.onload = function(){
  // Set up a MutationObserver to watch the output area
  window.port = document.getElementById('gameport');
  window.observer = new MutationObserver(mutations => {
    processNewLines(); // Run whenever something changes in #gameport
  });
  observer.observe(port, { childList: true, subtree: true });

  // Optionally run it once on page load
  processNewLines();
};