$(document).ready(function () {
    $('#basicTree').jstree({
        'core': { 'themes': { 'responsive': false } },
        'types': {
            'default': { 'icon': 'icofont icofont-folder' },
            'file': { 'icon': 'icofont icofont-file-alt' }
        }, 'plugins': ['types']
    });
    $('#checkTree').jstree({
        'core': { 'themes': { 'responsive': false } },
        'types': {
            'default': {
                'icon': 'icofont icofont-folder'
            }, 'file': { 'icon': 'icofont icofont-file-alt' }
        }, 'plugins': ['types', 'checkbox']
    });
    $('#dragTree').jstree({
        'core': { 'check_callback': true, 'themes': { 'responsive': false } },
        'types': {
            'default': { 'icon': 'icofont icofont-folder' },
            'file': { 'icon': 'icofont icofont-file-alt' }
        }, 'plugins': ['types', 'dnd']
    });
    $('#ajaxTree').jstree({
        'core': {
            'check_callback': true, 'themes': { 'responsive': false },
            'data': {
                'url': function (node) {
                    return node.id === '#' ? 'assets/plugins/jstree/ajax_roots.json' : 'assets/plugins/jstree/ajax_children.json';
                },
                'data': function (node) {
                    return { 'id': node.id };
                }
            }
        }, "types": {
            'default': { 'icon': 'icofont icofont-folder' }, 'file': { 'icon': 'icofont icofont-file-alt' }
        }, "plugins": ["contextmenu", "dnd", "search", "state", "types", "wholerow"]
    });
});