<script type="text/javascript">
        var markers = null;
        $(document).ready(function () {
            $.get("File.xml", {}, function (xml){
              $('marker',xml).each(function(i){
                 markers = $(this);
              });
            });
        });
</script>
