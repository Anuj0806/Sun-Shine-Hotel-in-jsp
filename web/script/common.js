  function dateDiff() {
                try {
                    var anuj = document.getElementById("price").value;    
                    var d1 = document.getElementById("cc_name").value;
                    var d2 = document.getElementById("cc1_name").value;
                    //var prize = document.getElementById("date").value;
                    const dateOne = new Date(d1);
                    const dateTwo = new Date(d2);
                    const time = Math.abs(dateTwo - dateOne);
                    var days = Math.ceil(time / (1000 * 60 * 60 * 24));
                    var pr = days * anuj;
                    document.getElementById("exampleInputAmount").value = pr;
                } catch (ex) {
                    alert(ex);
                }
            }