import QtQuick 2.0
import "../TableBase"
import "../../../common_component/SQL/SQLHelper"
import "../../../common_js/Tools.js" as Tools

TableBase {
    table_name: 'LiveRecord'
    table_field: ({
        title: 'TEXT',
        time_stamp: 'INT',
        start_time_stamp: 'INT',
        end_time_stamp: 'INT',
        save_path: 'TEXT',
        push_url: 'TEXT',
        template_id: 'TEXT',
        resolution: 'TEXT',
        frame_rate: 'TEXT',
    })

    function getLiveRecordById(id, callback) {
        let query = getTable().all().filter('id', '=', id)
        query.list(null, (data)=>{
            if (data.length === 0) {
                callback(null)
            }
            else {
                callback(data[0])
            }
        })
    }

    function deleteLiveRecordById(id, callback) {
        let query = getTable().all().filter('id', '=', id)
        query.list(null, function (data) {
           if (data.length === 0) {
               callback()
           }
           else {
               remove(data[0])
               save(callback)
           }
       })
    }

    function _getLiveRecordByAdvanceSearch(query, arg) {
        // let persistence = PersistenceSQL.instance()
        const { order_key } = arg
        let query_item = SQLTools.getRangeQueryByField('start_time_stamp', arg)
        if (query_item) {
            query = query.and(query_item)
        }
        query_item = SQLTools.getRangeQueryByField('end_time_stamp', arg)
        if (query_item) {
            query = query.and(query_item)
        }
        if (order_key) {
            query = query.order(order_key[0], order_key[1])
        }
        else {
            query = query.order('start_time_stamp', true)
        }
        return query
    }

    function getLiveRecordByAdvanceSearch(arg, index_from=null, index_to=null, call_back) {
        let query = _getLiveRecordByAdvanceSearch(getTable().all(), arg)
        query.count(null, function (all_count) {
            if (!Tools.isNone(index_from) && !Tools.isNone(index_to)) {
                query = query.skip(index_from).limit(index_to-index_from)
            }
            query.list(null, function (data) {
                let ans = []
                if (data.length === 0) {
                    call_back(all_count, ans)
                    return
                }
                data.forEach(function (item) {
                    ans.push(item)
                })
                call_back(all_count, ans)
            })
        })
    }
}
