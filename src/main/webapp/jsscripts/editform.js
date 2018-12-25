(function (W) {
    var D, form, bts, ipt;

    function init() {
        D = W.document, previous = [];
        form = D.getElementsByTagName('form')[0];
        bts = form.getElementsByTagName('button');
        ipt = form.getElementsByTagName('input');
        form.addEventListener('submit', save, false);
        bts[1].addEventListener('click', cancel, false);
        bts[2].addEventListener('click', edit, false);
    }

    function save(e) {
        e.preventDefault();
        form.classList.remove('invert');
        var l = ipt.length;
        while (l--) {
            ipt[l].readOnly = true;
        };
        previous = [];
        //send your info here 
    }

    function edit(e) {
        e.preventDefault();
        form.classList.add('invert');
        var l = ipt.length;
        while (l--) {
            previous[l] = ipt[l].value;
            ipt[l].readOnly = false;
        }
    }

    function cancel(e) {
        form.classList.remove('invert');
        e.preventDefault();
        var l = ipt.length;
        while (l--) {
            ipt[l].value = previous[l];
            ipt[l].readOnly = true;
        }
    }
    init();
})(window)