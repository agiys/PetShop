PGDMP                       |            petshop    16.3    16.3                 0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false                       0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false                       1262    16398    petshop    DATABASE     {   CREATE DATABASE petshop WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Russian_Russia.1251';
    DROP DATABASE petshop;
                postgres    false            �            1259    16453    Users    TABLE     _   CREATE TABLE public."Users" (
    id integer NOT NULL,
    "Name" text,
    "Password" text
);
    DROP TABLE public."Users";
       public         heap    postgres    false            �            1259    16460    Users_id_seq    SEQUENCE     �   ALTER TABLE public."Users" ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Users_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    223            �            1259    16427    cart    TABLE     r   CREATE TABLE public.cart (
    id integer NOT NULL,
    catalog_id integer,
    "user" text,
    count integer
);
    DROP TABLE public.cart;
       public         heap    postgres    false            �            1259    16437    cart_id_seq    SEQUENCE     �   ALTER TABLE public.cart ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.cart_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    219            �            1259    16399    catalog    TABLE     �   CREATE TABLE public.catalog (
    id integer NOT NULL,
    name text,
    description text,
    category_id integer,
    image_url text,
    price integer
);
    DROP TABLE public.catalog;
       public         heap    postgres    false            �            1259    16402    catalog_id_seq    SEQUENCE     �   ALTER TABLE public.catalog ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.catalog_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    215            �            1259    16408    category    TABLE     I   CREATE TABLE public.category (
    id integer NOT NULL,
    name text
);
    DROP TABLE public.category;
       public         heap    postgres    false            �            1259    16411    category_id_seq    SEQUENCE     �   ALTER TABLE public.category ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    217            �            1259    16440 	   favorites    TABLE     d   CREATE TABLE public.favorites (
    id integer NOT NULL,
    catalog_id integer,
    "user" text
);
    DROP TABLE public.favorites;
       public         heap    postgres    false            �            1259    16447    favorites_id_seq    SEQUENCE     �   ALTER TABLE public.favorites ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.favorites_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    221            	          0    16453    Users 
   TABLE DATA           9   COPY public."Users" (id, "Name", "Password") FROM stdin;
    public          postgres    false    223   z!                 0    16427    cart 
   TABLE DATA           =   COPY public.cart (id, catalog_id, "user", count) FROM stdin;
    public          postgres    false    219   �!                 0    16399    catalog 
   TABLE DATA           W   COPY public.catalog (id, name, description, category_id, image_url, price) FROM stdin;
    public          postgres    false    215   �!                 0    16408    category 
   TABLE DATA           ,   COPY public.category (id, name) FROM stdin;
    public          postgres    false    217   *                 0    16440 	   favorites 
   TABLE DATA           ;   COPY public.favorites (id, catalog_id, "user") FROM stdin;
    public          postgres    false    221   �*                  0    0    Users_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public."Users_id_seq"', 1, true);
          public          postgres    false    224                       0    0    cart_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.cart_id_seq', 63, true);
          public          postgres    false    220                       0    0    catalog_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.catalog_id_seq', 22, true);
          public          postgres    false    216                       0    0    category_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.category_id_seq', 5, true);
          public          postgres    false    218                       0    0    favorites_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.favorites_id_seq', 54, true);
          public          postgres    false    222            n           2606    16459    Users Users_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_pkey" PRIMARY KEY (id);
 >   ALTER TABLE ONLY public."Users" DROP CONSTRAINT "Users_pkey";
       public            postgres    false    223            j           2606    16431    cart cart_pkey 
   CONSTRAINT     L   ALTER TABLE ONLY public.cart
    ADD CONSTRAINT cart_pkey PRIMARY KEY (id);
 8   ALTER TABLE ONLY public.cart DROP CONSTRAINT cart_pkey;
       public            postgres    false    219            f           2606    16418    catalog catalog_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.catalog
    ADD CONSTRAINT catalog_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.catalog DROP CONSTRAINT catalog_pkey;
       public            postgres    false    215            h           2606    16420    category category_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.category DROP CONSTRAINT category_pkey;
       public            postgres    false    217            l           2606    16446    favorites favorites_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.favorites
    ADD CONSTRAINT favorites_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.favorites DROP CONSTRAINT favorites_pkey;
       public            postgres    false    221            p           2606    16432    cart catalog_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.cart
    ADD CONSTRAINT catalog_id FOREIGN KEY (catalog_id) REFERENCES public.catalog(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;
 9   ALTER TABLE ONLY public.cart DROP CONSTRAINT catalog_id;
       public          postgres    false    215    219    4710            q           2606    16448    favorites catalog_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.favorites
    ADD CONSTRAINT catalog_id FOREIGN KEY (catalog_id) REFERENCES public.catalog(id) NOT VALID;
 >   ALTER TABLE ONLY public.favorites DROP CONSTRAINT catalog_id;
       public          postgres    false    4710    221    215            o           2606    16421    catalog category_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.catalog
    ADD CONSTRAINT category_fk FOREIGN KEY (category_id) REFERENCES public.category(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;
 =   ALTER TABLE ONLY public.catalog DROP CONSTRAINT category_fk;
       public          postgres    false    4712    217    215            	      x�3�����,I��S\1z\\\ G�         0   x�3��4�����,I�4�23�4��̌8M��9Ma\C�=... �3*         %  x��W[o�F~�~_R4�)r�⭀$i��m�nv}*@�2�S�J��ɉ7I�1���b�_ �q�����眡e;)��@ř�|��Ό����Ϛ��D����ͮR�7[����ٮO�zց�sZ��9���:ê�_iZ?�Ǔ^���L6����\��8��HK�4W4�x�>�L;Aȃ��b��̲E��e����]�S�~��i����HF��hF�QR����ǐ>���x��q��17"_\���(~�ao�:F���?M�0��`�}�᱅��v��e�2���`��8�� 0,��5;�8�܆� ?W�����7���YL��`�d�(:�cJvf��v`]$��n]磴)�=H��>]|��e����(��M�HV>F�o0�,ѷb=L��&�2��Ǳ�B��uB�V����jv�W����^�(p
 	Nh�B�L�ˌ��ޤ��y&0���F�i��D��j�AM�ǖn;.Ж�T��]ֿ9A����b��������((�2_-B���<Z! 4�m��k�j
���	_um�t�۷-��ж��q��5����}2ߏ�� #���]f�<����7�Hl�i��2Qik~Z�j;����ZYh�<*5��"�f��}�a���0�PuִPg(<��<F�3��e��cD��E�����c��������{��$\�����E�U-1#�sn4����"��0X�箉��CK��qĦ�C'<@@]�n����b2� �*��ޠ��*	{a>�|+���3_�}�¿�qe�o���3����~,��j��~�n~�$���]v�������O�(;��t��1X��I}P��}Ղ(��$��@@7'��q!�(5T��u�um-/�A����m^����>��Ñ��k�9�D�M�w�;�'!�a�cٺ�]�1̶��t0C���|ЋD�O��4j!ڃot�5�����8��Qb���<����{(�~� �������JT.߁�JQ-�I%�6Eo৩(&^��AJ��ՠ?�f���(|5#@e�5��ORi��h�ɝ8�&d�h� ��bN�G��x�6\��ǰq	�m =��uf��a0G7%?M��?�^p/ߌD���jPk�� MB���K68\�6|�ަe����k���B�r�!X&Y2O�A�á���CsӢb�U�*|϶���=LB��	�*�@UU�TGI��|Ì���pZ�y+pذ��������os����{X`i�BM�%τ�bq������)��H��5����
,+�e������'�j���MAm��B������$`Ça�o	��9�8C��%E>5/�z����z_Zzf�XB7�dG��%��B�[�#��8����>a�0���������9f�(����n^Q�x��<�x����sX��S�N�������djF��+���#��)�z'!�3��٩zJ�x�	�@a�G��y�����ڧ\�8��{��A px�&�GX5�}0y �wdX	Y�S4(KzC��DQ	Z�6ȟ]�&� ȏ��e}���ԇ
�uN��)]s�6ne����z��m������=`����L��Hl�G��	�����gD�-�2S��1�h�y�9��ؓ��:���"a��m͏�K`rJ�=]�#��
Y�n/|�u|�3�����I��힒,(< .2����f�-���I�	����}!���P!���gy᧔>�  n��{q]�*1�x��P?�>#��%��8�vT�3 .Iq��Ȝ�ʷ��b.�Bb{O��:ߧ ��k�'n�)�8�I$��@P#�S��.�~I�9�Bo+-�G̛7���Ya���/�⪐wd���RI�_0�m��K`��N��2&���\�D�%�u����%��y/����&_gX3d+�p&�-j����-xz�����)�2�-�~��_����0F�!���`����V�"E��S[R.���m���)��_�O{WO�zo}L'�4Y�D�>����X�/��=g�י��ܟq�SE�*�c��o����n��x��,�e���?����� �1�c         �   x�=�K
�@D�ӧ�	��01A"��]1��I&W���5Q�^]��k���ǀ�%FtY�7�t��Gt�n�����Oɒ'A"^2��Ո,0���6w!-���E5����J�:�]��d��	�����vP��m�^G5��f��'~M         #   x�3�������,I�25�4��M8�`�=... � 	�     