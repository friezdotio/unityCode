jQuery(document).ready(function(){
    jQuery('.rx_isotope_ui').each(function(indx){
         rx_igallery = new RxIsotopeGallery();
         rx_igallery.init(jQuery(this));
    });
    handleBeacons();
});

function handleBeacons(){
        jQuery('.genericBeaconIsotope').each(function(indx){
            var beacon = jQuery(this);
            beacon.hover(function(e){
                TweenMax.to(jQuery(this).find('.beaconCircle1'), .3, {scale:1.5, opacity: 0, ease:Elastic.EaseOut});
                TweenMax.to(jQuery(this).find('.beaconCircle2'), .2, {scale:.95, opacity:.7, ease:Elastic.EaseOut});
            }, function(e){
                TweenMax.to(jQuery(this).find('.beaconCircle1'), .2, {scale:1, opacity: 1, ease:Elastic.EaseIn});
                TweenMax.to(jQuery(this).find('.beaconCircle2'), .1, {scale:1, opacity:1, ease:Elastic.EaseOut});
            });
        });
}

function RxIsotopeGallery(){

    var rx_gallery_ui;
    var main_gallery;
    this.init = function(ui){
        rx_gallery_ui = ui;
        initIsotopeMenu();
        handleLinks();
    }

    function handleLinks(){
        main_gallery = new Array();
        var isotopeItems = rx_gallery_ui.find('.isotopeContainer').children('.isotopeItem');
        for(var i=0;i<isotopeItems.length;i++){
            var overlay = jQuery(isotopeItems[i]).find('.isotopeItemOverlay');
            overlay.css('opacity', 0);
            overlay.css('display', 'block');
            var image_caption = overlay.find('.isotopeItemCaption').html();
            overlay.find('.isotopeItemCaption').remove();
            overlay.hover(function(e){
                var beacon = jQuery(this).find('.rx_isotope_beacon');
                beacon.css('left', jQuery(this).width()/2-beacon.width()/2+'px');
                beacon.css('top', jQuery(this).height()/2-beacon.height()/2+'px');
                TweenMax.to(jQuery(this), .2, {css:{opacity: 1}, ease:Power4.EaseIn});
            }, function(e){
                TweenMax.to(jQuery(this), .4, {css:{opacity: 0}, ease:Power4.EaseIn});
            });

            main_gallery.push({imgURL: overlay.attr('data-full_url'), itemDescription: image_caption});

            overlay.click(function(e){
                e.preventDefault();
                var indx = parseFloat(jQuery(this).attr('data-indx'));
                new IsotopeGalleryLightbox(main_gallery, indx, lightboxControlsColor);
            });
        }
    }

    var isotopeMenu;
    var selectedBackColor = '6abde9';
    var lightboxControlsColor = '6abde9';
    function initIsotopeMenu(){
        var menuUI = rx_gallery_ui.find('.isotopeMenu');
        selectedBackColor = menuUI.attr('data-selectedcolor');
        lightboxControlsColor = menuUI.attr('data-lightboxcolor');

        isotopeMenu = new Array();
        var menu_children = menuUI.children('li');

        for(var i=0;i<menu_children.length;i++){
            var link = jQuery(menu_children[i]).find('a');
            link.attr('data-indx', i);
            isotopeMenu.push({categoryID: link.attr('href'), link: link, iconClass: link.attr('class')});
            link.click(function(e){
                e.preventDefault();
                selectMenuItem(jQuery(this).attr('data-indx'));
            });
        }


        selectMenuItem(0);
    }

    //select isotope menu
    function selectMenuItem(indx){
        for(var i=0;i<isotopeMenu.length;i++){
            if(i==indx){
                isotopeMenu[i].link.css('background-color', '#'+selectedBackColor);
                filterIsotopeItems(indx);
            }else{
                isotopeMenu[i].link.css('background', 'none');
            }
        }
    }

    function filterIsotopeItems(index){
         var selector = "."+isotopeMenu[index].categoryID;
         (selector==".*")?selector="*":null;

         rx_gallery_ui.find('.isotopeContainer').isotope({
               layoutMode : 'masonry',
               filter: selector,
               animationOptions: {
                   duration: 750,
                   easing: 'linear',
                   queue: false
              }});
    }

}




    /* iGallery lightbox
    ================================================== */
   function IsotopeGalleryLightbox(original_gallery, index, controls_color){
       var _buttons_colors = (controls_color!=undefined)?controls_color:'6abde9';
       var gallery = new Array();
       for(var i=0;i<original_gallery.length;i++){
           gallery.push(original_gallery[i]);
       }


       var tmpl = ''+
       '<div id="sk_igallery_lightbox">'+
       '</div>';
       var preloaderTmpl = '<div class="iGalleryPreloader"><img src="isotope_gallery/images/preloader.gif" alt="preloader" /></div>';

       var containersTmpl = ''+
       '<p id="ilghtb_caption"></p>'+
       '<div id="ilghtb_img"></div>'+
       '<div id="ilghtb_controls">'+
            '<a href="#" class="genericBoxButtonLightbox ifloatRight lightBxRight" style="margin-left: 1px; background-color: #'+_buttons_colors+';"><img src="isotope_gallery/images/right.png" alt="" /></a>'+
            '<a href="#" class="genericBoxButtonLightbox ifloatRight lightBxClose" style="margin-left: 1px; background-color: #'+_buttons_colors+';"><img src="isotope_gallery/images/close.png" alt="" /></a>'+
            '<a href="#" class="genericBoxButtonLightbox ifloatRight lightBxLeft" style="background-color: #'+_buttons_colors+';"><img src="isotope_gallery/images/left_arrow.png" alt="" /></a>'+
        '</div>'+
       '';

       var secure_scr_tmpl = '<div id="isecure_screen"></div>';

    var leftBtn;
    var closeBtn;
    var rightBtn;

       var lgthBox;
       var iPreloader;
       var initialH = 70;
       var preloaderSize = 28;
       var currentIndex = index;

       var secure_UI;
       show();
       function show(){
           secure_UI = jQuery(secure_scr_tmpl);
           secure_screen(true);
           lgthBox = jQuery(tmpl);
           lgthBox.css('top', jQuery(window).height()/2+'px');
           lgthBox.appendTo('body');
           iPreloader = jQuery(preloaderTmpl);
           iPreloader.css('opacity', 0);
           TweenMax.to(iPreloader, 0, {css:{scale:0}});
           iPreloader.appendTo(lgthBox);
           jQuery(containersTmpl).appendTo(lgthBox);
           jQuery('#ilghtb_controls').css('opacity', 0);
           lightBoxResize();
           TweenMax.to(lgthBox, .3, {css:{opacity:1, height: initialH, top: (jQuery(window).height()/2-initialH/2)}, delay: .2, ease:Power3.EaseIn, onComplete: function(){
               lightBoxResize();
               TweenMax.to(iPreloader, .2, {css:{opacity:1, scale: 1}, ease:Power3.EaseIn, onComplete: function(){
                   loadImage(imageFirstTime);
               }});
           }});

            leftBtn = lgthBox.find('.lightBxLeft');
            closeBtn = lgthBox.find('.lightBxClose');
            rightBtn = lgthBox.find('.lightBxRight');

            buttonsHover();
            buttonsClick();
       }


        function buttonsHover(){
            leftBtn.hover(function(e){
                if(!leftValid){return;}
                    TweenMax.to(jQuery(this), .1, {css:{opacity:.8}, ease:Power3.easeIn});
                }, function(e){
                    if(!leftValid){return;}
                    TweenMax.to(jQuery(this), .1, {css:{opacity:1}, ease:Power3.easeIn});
                });
            closeBtn.hover(function(e){
                    TweenMax.to(jQuery(this), .1, {css:{opacity:.8}, ease:Power3.easeIn});
                }, function(e){
                    TweenMax.to(jQuery(this), .1, {css:{opacity:1}, ease:Power3.easeIn});
                });
            rightBtn.hover(function(e){
                if(!rightValid){return;}
                    TweenMax.to(jQuery(this), .1, {css:{opacity:.8}, ease:Power3.easeIn});
                }, function(e){
                    if(!rightValid){return;}
                    TweenMax.to(jQuery(this), .1, {css:{opacity:1}, ease:Power3.easeIn});
                });
        }

        function buttonsClick(){
            leftBtn.click(function(e){
                e.preventDefault();
                if(!leftValid){
                    return;
                }
                currentIndex--;
                initopenNewImage();
            });
            closeBtn.click(function(e){
                e.preventDefault();
                closeLightbox();
            });
            rightBtn.click(function(e){
                e.preventDefault();
                if(!rightValid){
                    return;
                }
                currentIndex++;
                initopenNewImage();
            });
        }


        function closeLightbox(){
            //secure_screen.secure(true);
            TweenMax.to(currentImage, .4, {css:{opacity: 0}, ease:Power3.easeIn});
            TweenMax.to(jQuery('#ilghtb_caption'), .4, {css:{opacity: 0}, delay: .2, ease:Power3.easeIn});
            TweenMax.to(jQuery('#ilghtb_controls'), .4, {css:{opacity: 0}, delay: .2, ease:Power3.easeIn});


            TweenMax.to(lgthBox, .5, {css:{height: '2px'}, delay: .6, ease:Power3.easeIn});
            TweenMax.to(lgthBox, .5, {css:{top: jQuery(window).height()/2+'px'}, delay: .6, ease:Power3.easeIn, onComplete: lightboxClosed});
        }

        function lightboxClosed(){
            //secure_screen.secure(false);
            TweenMax.to(lgthBox, .2, {css:{height: '0px'}, ease:Power3.easeIn, onComplete: gcc_lgtbox});
        }

        function gcc_lgtbox(){
            isActive = false;
            try{
                lgthBox.empty();
                lgthBox.remove();
                lgthBox = null;
                gallery = null;
                secure_UI.remove();
                secure_UI = null;
            }catch(e){}
        }

           function secure_screen(val){
               if(val){
                   try{
                      secure_UI.remove();
                   }catch(e){}
                   secure_UI.appendTo('body');
               }else{
                   secure_UI.remove();
               }
           }

        function initopenNewImage(){
            //secure_screen.secure(true);
            validateButtons();
            TweenMax.to(iPreloader, 0, {css:{opacity: 0, scale: 0}});
            TweenMax.to(currentImage, .4, {css:{opacity: 0}, ease:Power3.easeIn});
            TweenMax.to(iPreloader, .2, {css:{opacity: 1, scale: 1}, delay: .4, ease:Power3.easeIn, onComplete: loadNewImage});
            //preloaderGIF
        }

        function loadNewImage(){
            try{
                currentImage.remove();
            }catch(e){}
            loadImage(newImageLoaded);
        }

        function newImageLoaded(img){
            if(gallery[currentIndex].img==null){
                gallery[currentIndex].img = img;
            }
            TweenMax.to(iPreloader, .3, {css:{scale: 0, opacity: 0}, ease:Power3.easeIn});
            show_lgtb_image();
        }

        var leftValid = false;
        var rightValid = false;
        function validateButtons(){
            leftBtn.css('visibility', 'visible');
            rightBtn.css('visibility', 'visible');
            leftBtn.removeClass('iLightboxDisabledButton');
            rightBtn.removeClass('iLightboxDisabledButton');
            leftBtn.css('background-color', '#'+_buttons_colors);
            rightBtn.css('background-color', '#'+_buttons_colors);
            leftValid = true;
            rightValid = true;
            if(currentIndex==0){
                //leftBtn.css('visibility', 'hidden');
                //leftBtn.removeClass('portfolioButtonColor');
                leftBtn.addClass('iLightboxDisabledButton');
                leftBtn.css('background-color', '#'+'7b7b7b');
                leftValid = false;
            }
            if(currentIndex==gallery.length-1){
                //rightBtn.css('visibility', 'hidden');
                rightBtn.css('background-color', '#'+'7b7b7b');
                rightBtn.addClass('iLightboxDisabledButton');
                rightValid = false;
            }
            if(currentIndex!=gallery.length-1 && currentIndex!=0){
                leftBtn.css('visibility', 'visible');
                rightBtn.css('visibility', 'visible');
                leftBtn.removeClass('iLightboxDisabledButton');
                rightBtn.removeClass('iLightboxDisabledButton');
                leftValid = true;
                rightValid = true;
            }

        }


       function imageFirstTime(img){
           if(gallery[currentIndex].img==null){
               gallery[currentIndex].img = img;
           }
           expandLightbox();
       }

       function expandLightbox(){
           TweenMax.to(iPreloader, .2, {css:{opacity:0, scale: 0}, ease:Power3.EaseIn});
           TweenMax.to(lgthBox, .4, {css:{height:jQuery(window).height(), top: 0}, delay: .3, ease:Power3.EaseIn, onComplete: function(){
               lgthBox.css('height', '100%');
               show_lgtb_image();
           }});
       }

       var currentImage;
       var isActive;
       function show_lgtb_image(){
            if(gallery[currentIndex].img==undefined || gallery[currentIndex].img == "" || gallery[currentIndex].img ==null){
                //broken image
                return;
            }
            isActive = true;
            currentImage = gallery[currentIndex].img;
            currentImage.css('position', 'absolute');
            currentImage.css('max-width', '80%');
            currentImage.css('max-height', '80%');
            currentImage.css('opacity', 0);
            currentImage.appendTo(jQuery('#ilghtb_img'));
                currentImage.bind('contextmenu', function(e) {
                    return false;
                });
            jQuery('#ilghtb_caption').css('opacity', 0);
            jQuery('#ilghtb_caption').html(gallery[currentIndex].itemDescription);
            lightBoxResize();
            TweenMax.to(currentImage, .4, {css:{opacity: 1}, ease:Power3.easeIn});
            TweenMax.to(jQuery('#ilghtb_caption'), .4, {css:{opacity: 1}, delay: .2, ease:Power3.easeIn});
            TweenMax.to(jQuery('#ilghtb_controls'), .4, {css:{opacity: 1}, delay: .2, ease:Power3.easeIn});

            validateButtons();
            secure_screen(false);
       }

        jQuery(window).resize(function(){
             lightBoxResize();
        });


        function loadImage(callBack){
            var url = gallery[currentIndex].imgURL;
            var axjReq = new JQueryAJAX();
            axjReq.loadImage(url, function(img){
                callBack(img);
            });
        }


        function lightBoxResize(){
            try{
                iPreloader.css('top', lgthBox.height()/2-preloaderSize/2+'px');
                iPreloader.css('left', lgthBox.width()/2-preloaderSize/2+'px');

                if(isActive){
                    if(currentImage!=null&&currentImage!=undefined){
                        currentImage.css('left', lgthBox.width()/2-currentImage.width()/2+'px');
                        currentImage.css('top', lgthBox.height()/2-currentImage.height()/2+'px');
                    }
                }
                jQuery('#ilghtb_controls').css('left', lgthBox.width()/2-jQuery('#ilghtb_controls').width()/2+'px');

            }catch(e){}
        }

       function gcc_ilightbox(){
           try{

           }catch(e){}
       }
   }
    /* end iGallery lightbox
    ================================================== */


    function JQueryAJAX(){
        /**
         * load data trough get
         */
        this.getData = function(path, successCallBack, failCallBack){
            jQuery.get(path, function(response){
               //first responce
            }).error(function() { failCallBack(); })
            .success(function(response) {
                successCallBack(response);
            })
        }

        this.loadImage = function(path, successCallBack, failCallBack){
            var _url = path;
            var _im =jQuery("<img />");
            _im.bind("load",function(){
                    successCallBack(jQuery(this));
                });
            _im.attr('src',_url);
        }
    }



